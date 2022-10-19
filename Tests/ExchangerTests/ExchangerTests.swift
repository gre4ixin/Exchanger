import XCTest
@testable import Exchanger

final class ExchangerTests: XCTestCase {
    let exchange: ExchangeFacade = ExchangeService(enableDebugMode: true)
    
    func testHealth() async {
        let health = await exchange.healthCheck(blockchain: .BSC)
        switch health {
        case .success(let dto):
            print(dto)
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
    
    func testInfoTokens() async {
        let tokens = await exchange.tokens(blockchain: .polygon)
        
        switch tokens {
        case .success(let dto):
            dto.tokens.forEach {
                print($0.value)
                print("")
            }
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
    
    func testPresents() async {
        let presents = await exchange.presents(blockchain: .polygon)
        
        switch presents {
        case .success(let dto):
            dto.lowestGas?.forEach({
                print($0)
                print("")
            })
            
            dto.maxResult?.forEach({
                print($0)
                print("")
            })
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
    
    func testLiquidity() async {
        let liq = await exchange.liquiditySources(blockchain: .ethereum)
        
        switch liq {
        case .success(let dto):
            dto.protocols.forEach({
                print($0)
                print("")
            })
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
    
    func testGeneratingSwap() async {
        let amount = 1_000_000_000_000_000_000
        let response = await exchange.swap(blockchain: .polygon,
                                           parameters: SwapParameters(fromTokenAddress: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                                                                      toTokenAddress: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063",
                                                                      amount: "\(amount)",
                                                                      fromAddress: "0x2d45754375672e470E03beF24f4acC3cCD36973c",
                                                                      slippage: 1))
        switch response {
        case .success(let dto):
            print(dto)
            XCTAssert(true)
        case .failure(let error):
            print(error)
            XCTAssert(false)
        }
    }
    
    func testQuote() async {
        let response = await exchange.quote(blockchain: .polygon,
                                            parameters: QuoteParameters(fromTokenAddress: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                                                                        toTokenAddress: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063",
                                                                        amount: "10000000000000000"))
        switch response {
        case .success(let dto):
            print(dto)
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
    
    func testApproveSpender() async {
        let response = await exchange.spender(blockchain: .polygon)
        
        switch response {
        case .success(let dto):
            print(dto)
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
    
    func testApproveTransactionData() async {
        let response = await exchange.approveTransaction(blockchain: .polygon, approveTransactionParameters: .init(
            tokenAddress: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063",
            amount: .infinite))
        
        switch response {
        case .success(let dto):
            print(dto)
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
    
    func testApproveAllowance() async {
        let response = await exchange.allowance(blockchain: .polygon, allowanceParameters: .init(
            tokenAddress: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063", //DAI in polygon network
            walletAddress: "0x2d45754375672e470E03beF24f4acC3cCD36973c")) //Your wallet address
        
        switch response {
        case .success(let dto):
            print(dto)
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
}
