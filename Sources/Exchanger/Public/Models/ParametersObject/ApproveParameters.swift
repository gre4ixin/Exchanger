import Foundation

public struct ApproveTransactionParameters {
    public enum Amount {
        case infinite
        case specified(value: Int)
    }
    
    public let tokenAddress: String
    public let amount: Amount
    
    func parameters() -> [String: Any] {
        var params: [String: Any] = [:]
        switch amount {
        case .infinite:
            break
        case .specified(let value):
            params["amount"] = value
        }
        params["tokenAddress"] = tokenAddress
        return params
    }
}

public struct ApproveAllowanceParameters {
    public let tokenAddress: String
    public let walletAddress: String
}
