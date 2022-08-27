import Foundation

public enum ExchangeBlockchain {
    case ethereum
    case BSC
    case polygon
    case optimism
    case arbitrum
    case gnosisChain
    case avalanche
    case fantom
    case klayth
    case aurora
    
    var id: String {
        switch self {
        case .ethereum:
            return "1"
        case .BSC:
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
        case .klayth:
            return "8217"
        case .aurora:
            return "1313161554"
        }
    }
}
