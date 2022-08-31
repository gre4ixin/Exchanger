import Foundation

public protocol LimitOrderFacade: AnyObject {
    func ordersForAddress(blockchain: ExchangeBlockchain, parameters: OrdersForAddressParameters) async -> Result<[LimitOrderDTO], ExchangeError>
    func allOrders(blockchain: ExchangeBlockchain, parameters: OrdersAllParameters) async -> Result<[LimitOrderDTO], ExchangeError>
    func countOrders(blockchain: ExchangeBlockchain, statuses: [Statuses]) async -> Result<CountLimitOrdersDTO, ExchangeError>
    func events(blockchain: ExchangeBlockchain, limit: Int) async -> Result<[EventsLimitOrderDTO], ExchangeError>
    func hasActiveOrdersWithPermit(blockchain: ExchangeBlockchain, walletAddress: String, tokenAddress: String) async -> Result<ActiveOrdersWithPermitDTO, ExchangeError>
}

public class LimitOrderService: LimitOrderFacade {
    private let networkFacade: NetworkFacade = NetworkFacade()
    
    public func ordersForAddress(blockchain: ExchangeBlockchain, parameters: OrdersForAddressParameters) async -> Result<[LimitOrderDTO], ExchangeError> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: LimitOrderTarget.ordersForAddress(blockchain: blockchain, parameters: parameters)), decodeTo: [LimitOrderDTO].self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func allOrders(blockchain: ExchangeBlockchain, parameters: OrdersAllParameters) async -> Result<[LimitOrderDTO], ExchangeError> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: LimitOrderTarget.allOrders(blockchain: blockchain, parameters: parameters)), decodeTo: [LimitOrderDTO].self)
                
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
