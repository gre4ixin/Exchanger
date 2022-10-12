import Foundation

public protocol LimitOrderFacade: AnyObject {
    /// Get limit order for specific address
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - parameters: parameters for request
    /// - Returns: result of request
    func ordersForAddress(blockchain: ExchangeBlockchain, parameters: OrdersForAddressParameters) async -> Result<[LimitOrderModel], ExchangeError>
    /// All orders in 1inch
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - parameters: parameters for request
    /// - Returns: result of request
    func allOrders(blockchain: ExchangeBlockchain, parameters: OrdersAllParameters) async -> Result<[LimitOrderModel], ExchangeError>
    /// Count of all limit orders
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - statuses: array of filters [.valid, .temporaryInvalid, .invalid]
    /// - Returns: result of request
    func countOrders(blockchain: ExchangeBlockchain, statuses: [Statuses]) async -> Result<CountLimitOrdersDTO, ExchangeError>
    /// Get all events
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - limit: count of events
    /// - Returns: result request
    func events(blockchain: ExchangeBlockchain, limit: Int) async -> Result<[EventsLimitOrderDTO], ExchangeError>
    func hasActiveOrdersWithPermit(blockchain: ExchangeBlockchain, walletAddress: String, tokenAddress: String) async -> Result<ActiveOrdersWithPermitDTO, ExchangeError>
}

public class LimitOrderService: LimitOrderFacade {
    let enableDebugMode: Bool
    private lazy var networkFacade: NetworkFacade = NetworkFacade(debugMode: enableDebugMode)
    
    init(enableDebugMode: Bool) {
        self.enableDebugMode = enableDebugMode
    }
    
    public func ordersForAddress(blockchain: ExchangeBlockchain, parameters: OrdersForAddressParameters) async -> Result<[LimitOrderModel], ExchangeError> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: LimitOrderTarget.ordersForAddress(blockchain: blockchain, parameters: parameters)), decodeTo: [LimitOrderModel].self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func allOrders(blockchain: ExchangeBlockchain, parameters: OrdersAllParameters) async -> Result<[LimitOrderModel], ExchangeError> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: LimitOrderTarget.allOrders(blockchain: blockchain, parameters: parameters)), decodeTo: [LimitOrderModel].self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func countOrders(blockchain: ExchangeBlockchain, statuses: [Statuses]) async -> Result<CountLimitOrdersDTO, ExchangeError> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: LimitOrderTarget.countOrders(blockchain: blockchain, statuses: statuses)),
                                                           decodeTo: CountLimitOrdersDTO.self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func events(blockchain: ExchangeBlockchain, limit: Int) async -> Result<[EventsLimitOrderDTO], ExchangeError> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: LimitOrderTarget.events(blockchain: blockchain, limit: limit)),
                                                           decodeTo: [EventsLimitOrderDTO].self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func hasActiveOrdersWithPermit(blockchain: ExchangeBlockchain,
                                          walletAddress: String,
                                          tokenAddress: String) async -> Result<ActiveOrdersWithPermitDTO, ExchangeError> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: LimitOrderTarget.hasActiveOrdersWithPermit(blockchain: blockchain,
                                                                                                                              walletAddress: walletAddress,
                                                                                                                              tokenAddress: tokenAddress)),
                                                           decodeTo: ActiveOrdersWithPermitDTO.self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
}
