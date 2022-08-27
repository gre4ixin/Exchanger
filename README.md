# Exchange

1Inch exchange api wrapper with async/await swift.

```swift
let exchangeFacade: ExchangeFacade = ExchangeService()

// Get tokens info
Task { 
    let tokens = await exchangeFacade.tokens(blockchain: .polygon)
    switch tokens {
    case .success(let tokensDTO):
        dto.tokens.forEach {
            print($0.value)
        }
    case .failure(let error):
        print(error.localizedDescription)
    }
}

// Generation swap data

Task { 
    let amount = 1_000_000_000_000_000_000
    let fromAddress = "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    let toAddress = "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063"
    let response = await exchange.swap(blockchain: .polygon,
                                       parameters: SwapParameters(fromTokenAddress: fromAddress,
                                                                  toTokenAddress: toAddress,
                                                                  amount: "\(amount)",
                                                                  fromAddress: fromAddress,
                                                                  slippage: 1))
    switch response {
    case .success(let dto):
        print(dto.tx.data) // Data for sign and push to blockchain
    case .failure(let error):
        print(error)
    }
}
```

Supports **Ethereum**, **Binance smart chain**, **Polygon**, **Optimism**, **Arbitrum**, **Gnosis**, **Avalanche**, **Fantom**, **Klayth**, **Aurora**.
