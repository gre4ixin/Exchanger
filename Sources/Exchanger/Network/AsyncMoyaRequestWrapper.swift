import Foundation
import Moya

class AsyncMoyaRequestWrapper<T: Decodable> {
    internal typealias MoyaContinuation = CheckedContinuation<Result<T, ExchangeError>, Never>

    var performRequest: (MoyaContinuation) -> Moya.Cancellable?
    var cancellable: Moya.Cancellable?

    init(_ performRequest: @escaping (MoyaContinuation) -> Moya.Cancellable?) {
        self.performRequest = performRequest
    }

    func perform(continuation: MoyaContinuation) {
        cancellable = performRequest(continuation)
    }

    func cancel() {
        cancellable?.cancel()
    }
}
