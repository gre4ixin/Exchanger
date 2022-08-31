import Foundation
import Combine
import Moya

class NetworkFacade {
    private let provider = MoyaProvider<DexTarget>()
    
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func request<T: Decodable>(with target: DexTarget, decodeTo: T.Type) -> AnyPublisher<T, ExchangeError> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else { return }
                self.provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        guard let object = try? self.jsonDecoder.decode(decodeTo, from: response.data) else {
                            if let errorResponse = try? self.jsonDecoder.decode(ErrorDTO.self, from: response.data) {
                                promise(.failure(.parsedError(withInfo: errorResponse)))
                            } else {
                                promise(.failure(.unknownError(statusCode: 500)))
                            }
                            return
                        }
                        promise(.success(object))
                    case .failure(let error):
                        promise(.failure(.serverError(withError: error)))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func request<T: Decodable>(with target: DexTarget, decodeTo: T.Type) async -> Result<T, ExchangeError> {
        let asyncRequestWrapper = AsyncMoyaRequestWrapper<T> { [weak self] continuation in
            guard let self = self else { return nil }
            return self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    print("URL REQUEST -> \(response.request?.url?.absoluteString ?? "")")
                    guard let object = try? self.jsonDecoder.decode(decodeTo, from: response.data) else {
                        if let errorResponse = try? self.jsonDecoder.decode(ErrorDTO.self, from: response.data) {
                            continuation.resume(returning: .failure(.parsedError(withInfo: errorResponse)))
                        } else {
                            continuation.resume(returning: .failure(.unknownError(statusCode: 500)))
                        }
                        return
                    }
                    continuation.resume(returning: .success(object))
                case .failure(let error):
                    print("URL REQUEST -> \(error.response?.request?.url?.absoluteString ?? "")")
                    continuation.resume(returning: .failure(.serverError(withError: error)))
                }
            }
        }
        
        return await withTaskCancellationHandler(handler: {
            asyncRequestWrapper.cancel()
        }, operation: {
            await withCheckedContinuation({ continuation in
                asyncRequestWrapper.perform(continuation: continuation)
            })
        })
    }
}
