import Foundation

public struct ApproveTransactionParameters {
    public let tokenAddress: String
    public let amount: Int
}

public struct ApproveAllowanceParameters {
    public let tokenAddress: String
    public let walletAddress: String
}
