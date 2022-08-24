import Foundation
import Moya
import CombineMoya
import Combine

class NetworkFacade {
    private let provider = MoyaProvider<DexTarget>()
    
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func request<T: Decodable>(with target: DexTarget, decodeTo: T.Type) -> AnyPublisher<T, MoyaError> {
        return provider
            .requestPublisher(target)
            .filterSuccessfulStatusCodes()
            .map(decodeTo)
            .eraseToAnyPublisher()
    }
    
    func request<T: Decodable>(with target: DexTarget, decodeTo: T.Type) async -> Result<T, ErrorDTO> {
        await withCheckedContinuation({ continuation in
            provider.request(target) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    guard let object = try? self.jsonDecoder.decode(decodeTo, from: response.data) else {
                        if let errorResponse = try? self.jsonDecoder.decode(ErrorDTO.self, from: response.data) {
                            continuation.resume(returning: .failure(errorResponse))
                        } else {
                            continuation.resume(returning: .failure(ErrorDTO(statusCode: 500)))
                        }
                        return
                    }
                    continuation.resume(returning: .success(object))
                case .failure(let error):
                    continuation.resume(returning: .failure(ErrorDTO(statusCode: error.errorCode)))
                }
            }
        })
    }
}
