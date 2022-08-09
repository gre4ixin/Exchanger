import Foundation
import Moya

enum SwapTarget {
    //find the best quote to exchange via 1inch router
    case quote(blockchain: ExchangeBlockchain, parameters: QuoteParameters)
    //generate data for calling the 1inch router for exchange
    case swap(blockchain: ExchangeBlockchain, parameters: SwapParameters)
}

extension SwapTarget: TargetType {
    var baseURL: URL {
        InchAPIConstants.baseAPI
    }
    
    var path: String {
        switch self {
        case let .quote(blockchain, _):
            return "/\(blockchain.id)/quote"
        case let .swap(blockchain, _):
            return "/\(blockchain.id)/swap"
        }
    }
    
    var method: Moya.Method { return .get }
    
    var task: Task {
        switch self {
        case let .quote(_, parametersModel):
            return .requestParameters(parameters: parametersModel.parameters(), encoding: URLEncoding())
        case let .swap(_, parametersModel):
            return .requestParameters(parameters: parametersModel.parameters(), encoding: URLEncoding())
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
