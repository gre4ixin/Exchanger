import Foundation

public enum ExchangeBlockchain {
    case ethereum
    case binanceSmartChain
    case polygon
    case optimism
    case arbitrum
    case gnosisChain
    case avalanche
    case fantom
    
    var id: String {
        switch self {
        case .ethereum:
            return "1"
        case .binanceSmartChain:
            return "56"
        case .polygon:
            return "137"
        case .optimism:
            return "10"
        case .arbitrum:
            return "42161"
        case .gnosisChain:
            return "100"
        case .avalanche:
            return "43114"
        case .fantom:
            return "250"
        }
    }
}

struct InchAPIConstants {
    static let baseAPI: URL = URL(string: "https://api.1inch.io/v4.0")!
}
