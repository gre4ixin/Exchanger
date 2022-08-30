import Foundation

struct InchAPIConstants {
    enum APIVersion: String {
        case v1 = "v1.0"
        case v2 = "v2.0"
        case v3 = "v3.0"
        case v4 = "v4.0"
    }
    
    static let limitAPIBaseURL: URL = URL(string: "https://limit-orders.1inch.io/\(APIVersion.v2.rawValue)")!
    static let exchangeAPIBaseURL: URL = URL(string: "https://api.1inch.io/\(APIVersion.v4.rawValue)")!
}
