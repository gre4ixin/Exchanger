import Foundation
import Moya

enum LimitOrderTarget {
    case ordersForAddress(blockchain: ExchangeBlockchain, parameters: OrdersForAddressParameters)
    case allOrders(blockchain: ExchangeBlockchain, parameters: OrdersAllParameters)
    case countOrders(blockchain: ExchangeBlockchain, statuses: [Statuses])
    case events(blockchain: ExchangeBlockchain, limit: Int)
    case eventsForOrder(blockchain: ExchangeBlockchain, orderHash: String)
    case hasActiveOrdersWithPermit(blockchain: ExchangeBlockchain, walletAddress: String, tokenAddress: String)
}

extension LimitOrderTarget: TargetType {
    var baseURL: URL {
        ExchangeConstants.limitAPIBaseURL
    }
    
    var path: String {
        switch self {
        case .ordersForAddress(let blockchain, let parameters):
            return "/\(blockchain.id)/limit-order/address/\(parameters.address)"
        case .allOrders(let blockchain, _):
            return "/\(blockchain.id)/limit-order/all"
        case .countOrders(let blockchain, _):
            return "/\(blockchain.id)/limit-order/count"
        case .events(let blockchain, _):
            return "/\(blockchain.id)/limit-order/events"
        case .eventsForOrder(let blockchain, let orderHash):
            return "/\(blockchain.id)/limit-order/events/\(orderHash)"
        case .hasActiveOrdersWithPermit(let blockchain, let walletAddress, let tokenAddress):
            return "/\(blockchain.id)/limit-order/has-active-orders-with-permit/\(walletAddress)/\(tokenAddress)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .ordersForAddress, .allOrders, .countOrders, .events, .eventsForOrder, .hasActiveOrdersWithPermit:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .ordersForAddress(_, let parameters):
            return .requestParameters(parameters: parameters.parameters(), encoding: URLEncoding())
        case .allOrders(_, let parameters):
            return .requestParameters(parameters: parameters.parameters(), encoding: URLEncoding())
        case .countOrders(_, let parameters):
            let statuses = "\(parameters.map({ $0.rawValue }).sorted())"
            return .requestParameters(parameters: ["statuses": statuses], encoding: URLEncoding())
        case .events(_, let limit):
            return .requestParameters(parameters: ["limit": limit], encoding: URLEncoding())
        case .eventsForOrder, .hasActiveOrdersWithPermit:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? { return nil }
}
