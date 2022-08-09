import Foundation

public struct InfoTokensDTO: Decodable {
    let tokens: [String: TokenDTO]
}

// MARK: - Token
public struct TokenDTO: Decodable {
    let symbol, name: String
    let decimals: Int
    let address: String
    let logoURI: String
    let tags: [TagDTO]
    let eip2612, isFoT: Bool?
    let domainVersion: String?
    let synth: Bool?
    let displayedSymbol: String?
}

public enum TagDTO: String, Decodable {
    case native = "native"
    case pools = "pools"
    case savings = "savings"
    case tokens = "tokens"
}

public struct PresentsConfigurationDTO: Decodable {
    public let maxResult, lowestGas: [GasDTO]

    enum CodingKeys: String, CodingKey {
        case maxResult = "MAX_RESULT"
        case lowestGas = "LOWEST_GAS"
    }
}

public struct GasDTO: Decodable {
    public let complexityLevel, mainRouteParts, parts, virtualParts: Int
}

public struct LiquiditySourcesDTO: Decodable {
    public let protocols: [ProtocolElement]
}
