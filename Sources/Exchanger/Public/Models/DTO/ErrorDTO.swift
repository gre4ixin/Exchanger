import Foundation

public enum ExchangeError: Error {
    case unknownError(statusCode: Int?)
    case serverError(withError: Error)
    case parsedError(withInfo: ErrorDTO)
}

public struct ErrorDTO: Decodable, Error {
    public let statusCode: Int
    public let error: String
    public let description: String
    public let requestId: String
    public let meta: Meta
    
    public struct Meta: Decodable {
        public let type: String
        public let value: String
        
        internal init(type: String = "", value: String = "") {
            self.type = type
            self.value = value
        }
    }
    
    internal init(statusCode: Int, error: String = "", description: String = "", requestId: String = "", meta: ErrorDTO.Meta = .init()) {
        self.statusCode = statusCode
        self.error = error
        self.description = description
        self.requestId = requestId
        self.meta = meta
    }
}
