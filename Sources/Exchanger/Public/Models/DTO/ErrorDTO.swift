import Foundation

struct ErrorDTO: Decodable, Error {
    let statusCode: Int
    let error: String
    let description: String
    let requestId: String
    let meta: Meta
    
    struct Meta: Decodable {
        let type: String
        let value: String
    }
}
