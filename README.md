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
    func testGeneratingSwap() async {
        let response = await exchange.swap(blockchain: .polygon,
                                           parameters: SwapParameters(fromTokenAddress: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                                                                      toTokenAddress: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063",
                                                                      amount: "1000000000000000000",
                                                                      fromAddress: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                                                                      slippage: "1"))
        switch response {
        case .success(let dto):
            print(dto.tx.data) // Data for sign and push to blockchain
        case .failure(let error):
            print(error)
        }
    }
}
```

Supports **Ethereum**, **Binance smart chain**, **Polygon**, **Optimism**, **Arbitrum**, **Gnosis**, **Avalanche**, **Fantom**, **Klayth**, **Aurora**.