import Foundation

/// - limit-order/address/{address}
/// - limit-order/all
public struct LimitOrderModel: Codable {
    public let signature, orderHash, createDateTime, remainingMakerAmount: String
    public let makerBalance, makerAllowance: String
    public let data: MetaData
    public let makerRate, takerRate: String
    public let isMakerContract: Bool
    
    public struct MetaData: Codable {
        /// maker asset -> "you sell"
        /// taker asset -> "you buy"
        public let makerAsset, takerAsset, getMakerAmount, getTakerAmount: String
        public let makerAssetData, takerAssetData, salt, permit: String
        public let predicate, interaction, receiver, allowedSender: String
        public let makingAmount, takingAmount, maker: String
    }
}

public struct CountLimitOrdersDTO: Decodable {
    public let count: Int
}

public struct EventsLimitOrderDTO: Decodable {
    public let id, network: Int
    public let logID: String
    public let version: Int
    public let action, orderHash, taker, remainingMakerAmount: String
    public let transactionHash: String
    public let blockNumber: Int
    public let createDateTime: String
    
    enum CodingKeys: String, CodingKey {
        case id, network
        case logID = "logId"
        case version, action, orderHash, taker, remainingMakerAmount, transactionHash, blockNumber, createDateTime
    }
}

public struct ActiveOrdersWithPermitDTO: Decodable {
    public let result: Bool
}
