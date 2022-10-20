import Foundation

//MARK: - Quote
public struct QuoteDTO: Decodable {
    public let fromToken, toToken: Token
    public let toTokenAmount, fromTokenAmount: String
    public let protocols: [[[ProtocolElement]]]
    public let estimatedGas: Int
}

public struct Token: Decodable {
    public let symbol, name, address: String
    public let decimals: Int
    public let logoURI: String
}

public struct ProtocolElement: Decodable {
    public let name: String
    public let part: Int
    public let fromTokenAddress, toTokenAddress: String
}

//MARK: - Swap
public struct SwapDTO: Decodable {
    public let fromToken, toToken: SwapTokenDTO
    public let toTokenAmount, fromTokenAmount: String
    public let protocols: [[[ProtocolElement]]]
    public let tx: Tx
}

public struct SwapTokenDTO: Decodable {
    public let symbol, name: String
    public let decimals: Int
    public let address: String
    public let logoURI: String
    public let tags: [String]
}

public struct Tx: Codable {
    public let from, to, data, value: String
    public let gas: Int
    //GWEI
    public let gasPrice: String
}

