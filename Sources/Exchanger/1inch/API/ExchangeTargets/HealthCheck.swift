import Moya
import Foundation

enum HealthCheckTarget {
    case healthCheck(blockChain: ExchangeBlockchain)
}

extension HealthCheckTarget: TargetType {
    var baseURL: URL {
        InchAPIConstants.exchangeAPIBaseURL
    }
    
    var path: String {
        switch self {
        case .healthCheck(let blockChainID):
            return "/\(blockChainID.id)/healthcheck"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
