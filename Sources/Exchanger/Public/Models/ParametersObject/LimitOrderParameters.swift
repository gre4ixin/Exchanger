import Foundation

public enum Statuses: Int {
    case valid = 1
    case temporaryInvalid = 2
    case invalid = 3
}

public struct OrdersForAddressParameters {
    public var address: String
    public var page: Int = 1
    public var limit: Int = 100
    public var statuses: [Statuses] = []
    public var makerAsset: String?
    public var takerAsset: String?
    
    public init(
        address: String,
        page: Int = 1,
        limit: Int = 100,
        statuses: [Statuses] = [],
        makerAsset: String? = nil,
        takerAsset: String? = nil
    ) {
        self.address = address
        self.page = page
        self.limit = limit
        self.statuses = statuses
        self.takerAsset = takerAsset
        self.makerAsset = makerAsset
    }
    
    func parameters() -> [String: Any] {
        var params: [String: Any] = [:]
        params["page"] = page
        params["limit"] = limit
        params["statuses"] = "\(statuses.map({ $0.rawValue }).sorted())"
        if let takerAsset = takerAsset {
            params["takerAsset"] = takerAsset
        }
        if let makerAsset = makerAsset {
            params["makerAsset"] = makerAsset
        }
        return params
    }
}

public struct OrdersAllParameters {    
    public var page: Int = 1
    public var limit: Int = 100
    public var statuses: [Statuses] = []
    public var makerAsset: String?
    public var takerAsset: String?
    
    public init(
        page: Int = 1,
        limit: Int = 100,
        statuses: [Statuses] = [],
        makerAsset: String? = nil,
        takerAsset: String? = nil
    ) {
        self.page = page
        self.limit = limit
        self.statuses = statuses
        self.takerAsset = takerAsset
        self.makerAsset = makerAsset
    }
    
    func parameters() -> [String: Any] {
        var params: [String: Any] = [:]
        params["page"] = page
        params["limit"] = limit
        if !statuses.isEmpty {
            params["statuses"] = "\(statuses.map({ $0.rawValue }).sorted())"
        }
        if let takerAsset = takerAsset {
            params["takerAsset"] = takerAsset
        }
        if let makerAsset = makerAsset {
            params["makerAsset"] = makerAsset
        }
        return params
    }
}
    
