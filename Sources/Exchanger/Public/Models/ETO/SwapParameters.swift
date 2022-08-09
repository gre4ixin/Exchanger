import Foundation

struct QuoteParameters {
    var fromTokenAddress: String
    var toTokenAddress: String
    var amount: String
    var protocols: String?
    var fee: String?
    var gasLimit: String?
    var complexityLevel: String?
    var mainRouteParts: String?
    var parts: String?
    var gasPrice: String?
    
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

struct SwapParameters {
    var fromTokenAddress: String
    var toTokenAddress: String
    var amount: String
    var fromAddress: String
    var slippage: String
    var disableEstimate: Bool?
    var protocols: String?
    var destReceiver: String?
    var referrerAddress: String?
    var fee: String?
    var burnChi: Bool?
    var allowPartialFill: Bool?
    var parts: String?
    var mainRouteParts: String?
    var connectorTokens: String?
    var complexityLevel: String?
    var gasLimit: String?
    var gasPrice: String?
    
    func parameters() -> [String: Any] {
        var params: [String: Any] = [
            "fromTokenAddress": fromTokenAddress,
            "toTokenAddress": toTokenAddress,
            "amount": amount,
            "fromAddress": fromAddress,
            "slippage": slippage
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
