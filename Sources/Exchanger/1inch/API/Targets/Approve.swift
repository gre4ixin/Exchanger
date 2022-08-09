import Foundation
import Moya

enum InchApprove {
    case spender(blockChain: ExchangeBlockchain)
    case transaction(blockChain: ExchangeBlockchain, params: ApproveTransaction)
    case allowance(blockChain: ExchangeBlockchain, params: ApproveAllowance)
}

extension InchApprove: TargetType {
    var baseURL: URL {
        InchAPIConstants.baseAPI
    }
    
    var path: String {
        switch self {
        case .spender(let blockChain):
            return "/\(blockChain.id)/approve/spender"
        case .transaction(let blockChain, _):
            return "/\(blockChain.id)/approve/transaction"
        case .allowance(let blockChain, _):
            return "/\(blockChain.id)/approve/allowance"
        }
    }
    
    var method: Moya.Method { return .get }
    
    var task: Task {
        switch self {
        case .spender:
            return .requestPlain
        case .transaction(_, let params):
            return .requestParameters(parameters: ["tokenAddress": params.tokenAddress, "amount": "\(params.amount)"], encoding: URLEncoding())
        case .allowance(_, let params):
            return .requestParameters(parameters: ["tokenAddress": params.tokenAddress, "walletAddress": params.walletAddress], encoding: URLEncoding())
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
