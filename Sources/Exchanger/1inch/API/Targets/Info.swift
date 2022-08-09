import Foundation
import Moya

enum InfoTarget {
    case liquiditySources(blockchain: ExchangeBlockchain)
    //List of tokens that are available for swap
    case tokens(blockchain: ExchangeBlockchain)
    //List of presets configurations for the 1inch router
    case presets(blockchain: ExchangeBlockchain)
}

extension InfoTarget: TargetType {
    var baseURL: URL {
        InchAPIConstants.baseAPI
    }
    
    var path: String {
        switch self {
        case .liquiditySources(let blockchain):
            return "/\(blockchain.id)/liquidity-sources"
        case .tokens(let blockchain):
            return "/\(blockchain.id)/tokens"
        case .presets(let blockchain):
            return "/\(blockchain.id)/presets"
        }
    }
    
    var method: Moya.Method { return .get }
    
    var task: Task {
        switch self {
        case .liquiditySources:
            return .requestPlain
        case .tokens:
            return .requestPlain
        case .presets:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
