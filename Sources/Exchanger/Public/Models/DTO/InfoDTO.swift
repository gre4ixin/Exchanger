import Foundation

public struct InfoTokensDTO: Decodable {
    public let tokens: [String: TokenDTO]
}

// MARK: - Token
public struct TokenDTO: Decodable {
    public let symbol, name: String
    public let decimals: Int
    public let address: String
    public let logoURI: String
    public let tags: [String]
    public let eip2612, isFoT: Bool?
    public let domainVersion: String?
    public let synth: Bool?
    public let displayedSymbol: String?
}

public struct PresentsConfigurationDTO: Decodable {
    public let maxResult: [GasDTO]?
    public let lowestGas: [GasDTO]?

    enum CodingKeys: String, CodingKey {
        case maxResult = "MAX_RESULT"
        case lowestGas = "LOWEST_GAS"
    }
}

public struct GasDTO: Decodable {
    public let complexityLevel, mainRouteParts, parts, virtualParts: Int
}

public struct LiquiditySourcesDTO: Decodable {
    public let protocols: [LiquidityProtocol]
}

public struct LiquidityProtocol: Decodable {
    public let id: String
    public let title: String
    public let img: String
    public let imgColor: String?
    
    enum CodingKeys: String, CodingKey {
        case imgColor = "img_color"
        case id, title, img
    }
}
