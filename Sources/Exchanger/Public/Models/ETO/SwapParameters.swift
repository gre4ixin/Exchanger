import Foundation

public struct QuoteParameters {
    public var fromTokenAddress: String
    public var toTokenAddress: String
    public var amount: String
    public var protocols: String?
    public var fee: String?
    public var gasLimit: String?
    public var complexityLevel: String?
    public var mainRouteParts: String?
    public var parts: String?
    public var gasPrice: String?
    
    func parameters() -> [String: Any] {
        var params: [String: Any] = [
            "fromTokenAddress": fromTokenAddress,
            "toTokenAddress": toTokenAddress,
            "amount": amount
        ]
        
        if let gasLimit = gasLimit {
            params["gasLimit"] = gasLimit
        }
        
        if let gasPrice = gasPrice {
            params["gasPrice"] = gasPrice
        }
        
        if let fee = fee {
            params["fee"] = fee
        }
        
        if let complexityLevel = complexityLevel {
            params["complexityLevel"] = complexityLevel
        }
        
        if let mainRouteParts = mainRouteParts {
            params["mainRouteParts"] = mainRouteParts
        }
        
        if let parts = parts {
            params["parts"] = parts
        }
        
        if let protocols = protocols {
            params["protocols"] = protocols
        }
        
        return params
    }
}

public struct SwapParameters {
    public var fromTokenAddress: String
    public var toTokenAddress: String
    public var amount: String
    public var fromAddress: String
    public var slippage: Int
    public var disableEstimate: Bool?
    public var protocols: String?
    public var destReceiver: String?
    public var referrerAddress: String?
    public var fee: String?
    public var burnChi: Bool?
    public var allowPartialFill: Bool?
    public var parts: String?
    public var mainRouteParts: String?
    public var connectorTokens: String?
    public var complexityLevel: String?
    public var gasLimit: String?
    public var gasPrice: String?
    
    func parameters() -> [String: Any] {
        var params: [String: Any] = [
            "fromTokenAddress": fromTokenAddress,
            "toTokenAddress": toTokenAddress,
            "amount": amount,
            "fromAddress": fromAddress,
            "slippage": "\(slippage)"
        ]
        if let disableEstimate = disableEstimate {
            params["disableEstimate"] = disableEstimate
        }
        
        if let referrerAddress = referrerAddress {
            params["referrerAddress"] = referrerAddress
        }
        
        if let allowPartialFill = allowPartialFill {
            params["allowPartialFill"] = allowPartialFill
        }
        
        if let gasLimit = gasLimit {
            params["gasLimit"] = gasLimit
        }
        
        if let gasPrice = gasPrice {
            params["gasPrice"] = gasPrice
        }
        
        if let protocols = protocols {
            params["protocols"] = protocols
        }
        
        if let destReceiver = destReceiver {
            params["destReceiver"] = destReceiver
        }
        
        if let fee = fee {
            params["fee"] = fee
        }
        
        if let burnChi = burnChi {
            params["burnChi"] = burnChi
        }
        
        if let parts = parts {
            params["parts"] = parts
        }
        
        if let mainRouteParts = mainRouteParts {
            params["mainRouteParts"] = mainRouteParts
        }
        
        if let complexityLevel = complexityLevel {
            params["complexityLevel"] = complexityLevel
        }
        return params
    }
}
