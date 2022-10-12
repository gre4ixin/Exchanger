import XCTest
@testable import Exchanger

final class LimitTests: XCTestCase {
    let limit: LimitOrderFacade = LimitOrderService(enableDebugMode: true)
    
    func testLimitForAddress() async {
        let response = await limit.ordersForAddress(blockchain: .polygon, parameters: .init(address: "0x2d45754375672e470E03beF24f4acC3cCD36973c"))
        
        let params = OrdersAllParameters.init(statuses: [.invalid, .temporaryInvalid])
        print(params.parameters())
        switch response {
        case .success(let objects):
            for object in objects {
                print(object)
            }
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
    
    func testAllLimits() async {
        let response = await limit.allOrders(blockchain: .polygon, parameters: .init())
        
        switch response {
        case .success(let objects):
            for object in objects {
                print(object)
            }
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
    
    func testCountOrders() async {
        let response = await limit.countOrders(blockchain: .polygon, statuses: [.valid, .temporaryInvalid])
        switch response {
        case .success(let object):
            print(object.count)
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
    
    func testEvents() async {
        let response = await limit.events(blockchain: .polygon, limit: 100)
        switch response {
        case .success(let object):
            print(object)
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
    
    func testActiveOrdersWithPermit() async {
        let response = await limit.hasActiveOrdersWithPermit(blockchain: .polygon,
                                                             walletAddress: "0x2d45754375672e470E03beF24f4acC3cCD36973c",
                                                             tokenAddress: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063")
        switch response {
        case .success(let object):
            print(object)
            XCTAssert(true)
        case .failure(let error):
            print(error.localizedDescription)
            XCTAssert(false)
        }
    }
}
