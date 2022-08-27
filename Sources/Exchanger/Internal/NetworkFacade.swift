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
    
    func request<T: Decodable>(with target: DexTarget, decodeTo: T.Type) -> AnyPublisher<T, ErrorDTO> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else { return }
                self.provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        guard let object = try? self.jsonDecoder.decode(decodeTo, from: response.data) else {
                            if let errorResponse = try? self.jsonDecoder.decode(ErrorDTO.self, from: response.data) {
                                promise(.failure(errorResponse))
                            } else {
                                promise(.failure(.init(statusCode: 500)))
                            }
                            return
                        }
                        promise(.success(object))
                    case .failure(let error):
                        promise(.failure(.init(statusCode: error.errorCode)))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func request<T: Decodable>(with target: DexTarget, decodeTo: T.Type) async -> Result<T, ErrorDTO> {
        let asyncRequestWrapper = AsyncMoyaRequestWrapper<T> { [weak self] continuation in
            guard let self = self else { return nil }
            return self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    guard let object = try? self.jsonDecoder.decode(decodeTo, from: response.data) else {
                        if let errorResponse = try? self.jsonDecoder.decode(ErrorDTO.self, from: response.data) {
                            continuation.resume(returning: .failure(errorResponse))
                        } else {
                            let description = String(data: response.data, encoding: .utf8) ?? ""
                            continuation.resume(returning: .failure(ErrorDTO(statusCode: 500, description: description)))
                        }
                        return
                    }
                    continuation.resume(returning: .success(object))
                case .failure(let error):
                    continuation.resume(returning: .failure(ErrorDTO(statusCode: error.errorCode)))
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
