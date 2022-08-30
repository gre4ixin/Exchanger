import Foundation
import Moya
import Combine

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
                                promise(.failure(.serverError(withInfo: errorResponse)))
                            } else {
                                promise(.failure(.unknownError))
                            }
                            return
                        }
                        promise(.success(object))
                    case .failure(let error):
                        promise(.failure(.nonServerSideError(withError: error)))
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
                    guard let object = try? self.jsonDecoder.decode(decodeTo, from: response.data) else {
                        if let errorResponse = try? self.jsonDecoder.decode(ErrorDTO.self, from: response.data) {
                            continuation.resume(returning: .failure(.serverError(withInfo: errorResponse)))
                        } else {
                            continuation.resume(returning: .failure(.unknownError))
                        }
                        return
                    }
                    continuation.resume(returning: .success(object))
                case .failure(let error):
                    continuation.resume(returning: .failure(.nonServerSideError(withError: error)))
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
