import XCTest
@testable import Exchanger

final class ExchangerTests: XCTestCase {
    let facade = NetworkFacade()
    let exchange: ExchangeFacade = ExchangeService()
    
    func testAsyncRequest() async {
        let swapResult = await facade
            .request(with: DexTarget(target: SwapTarget.swap(blockchain: .ethereum,
                                                             parameters: SwapParameters(fromTokenAddress: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                                                                                 toTokenAddress: "0x6b175474e89094c44da98b954eedeac495271d0f",
                                                                                 amount: "20000000000000000",
                                                                                 fromAddress: "0xB09e07a2d4E432BF843c17A4b4B9e94B2e00cfc5",
                                                                                 slippage: "1", fee: "1"))), decodeTo: SwapDTO.self)
        switch swapResult {
        case .success(let response):
            print(response.tx)
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
    
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
        let tokens = await exchange.tokens(blockchain: .ethereum)
        
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
        let presents = await exchange.presents(blockchain: .arbitrum)
        
        switch presents {
        case .success(let dto):
            print(dto)
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
}
