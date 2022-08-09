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
    
    func request<T: Decodable>(with target: DexTarget, decodeTo: T.Type) async -> Result<T, MoyaError> {
        await withCheckedContinuation({ continuation in
            provider.request(target) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
//                    print(response.request?.url?.absoluteString ?? "")
//                    let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
//                    print(json)
                    guard let object = try? self.jsonDecoder.decode(decodeTo, from: response.data) else {
                        let error = MoyaError.statusCode(.init(statusCode: 500, data: response.data))
                        continuation.resume(returning: .failure(error))
                        return
                    }
                    continuation.resume(returning: .success(object))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
}
