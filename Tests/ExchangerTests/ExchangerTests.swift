import XCTest
@testable import Exchanger

final class ExchangerTests: XCTestCase {
    let facade = NetworkFacade()
    
    func testAsyncRequest() async {
        let result = await facade.request(with: DexTarget(target: InfoTarget.tokens(blockchain: .ethereum)), decodeTo: InfoTokensDTO.self)
        switch result {
        case .success(let response):
//            for item in response.tokens {
//                print("\(item.key)")
//                print("\(item.value)")
//                print("__________________")
//            }
            break
        case .failure(let error):
            print(error)
        }
        let swapResult = await facade.request(with: DexTarget(target: SwapTarget.swap(blockchain: .ethereum, parameters: SwapETO(fromTokenAddress: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                                                                                                                                          toTokenAddress: "0x6b175474e89094c44da98b954eedeac495271d0f",
                                                                                                                                          amount: "20000000000000000",
                                                                                                                                          fromAddress: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                                                                                                                                          slippage: "1", fee: "1"))), decodeTo: SwapDTO.self)
        switch swapResult {
        case .success(let response):
            print(response.tx)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
