import Foundation

public protocol ExchangeFacade: AnyObject {
    /// Check status of service
    /// - Parameter blockchain: blockchain
    func healthCheck(blockchain: ExchangeBlockchain) async -> Result<HealthCheckDTO, Error>
    
    /// blockchainID/tokens
    /// - Parameter blockchain: ExchangeBlockchain type
    /// - Returns: request result
    func tokens(blockchain: ExchangeBlockchain) async -> Result<InfoTokensDTO, Error>
    func presents(blockchain: ExchangeBlockchain) async -> Result<PresentsConfigurationDTO, Error>
    func liquiditySources(blockchain: ExchangeBlockchain) async -> Result<LiquiditySourcesDTO, Error>
    
    /// Find best quote to exchange
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - parameters: parameters for exchange
    func quote(blockchain: ExchangeBlockchain, parameters: QuoteParameters) async -> Result<QuoteDTO, Error>
    /// Generating data for exchange
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - parameters: parameters for exchange
    func swap(blockchain: ExchangeBlockchain, parameters: SwapParameters) async -> Result<SwapDTO, Error>
}

public class ExchangeService: ExchangeFacade {
    private let networkFacade: NetworkFacade = NetworkFacade()
    
    public func healthCheck(blockchain: ExchangeBlockchain) async -> Result<HealthCheckDTO, Error> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: HealthCheckTarget.healthCheck(blockChain: blockchain)), decodeTo: HealthCheckDTO.self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func tokens(blockchain: ExchangeBlockchain) async -> Result<InfoTokensDTO, Error> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: InfoTarget.tokens(blockchain: blockchain)), decodeTo: InfoTokensDTO.self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func presents(blockchain: ExchangeBlockchain) async -> Result<PresentsConfigurationDTO, Error> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: InfoTarget.presets(blockchain: blockchain)), decodeTo: PresentsConfigurationDTO.self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func liquiditySources(blockchain: ExchangeBlockchain) async -> Result<LiquiditySourcesDTO, Error> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: InfoTarget.liquiditySources(blockchain: blockchain)), decodeTo: LiquiditySourcesDTO.self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func quote(blockchain: ExchangeBlockchain, parameters: QuoteParameters) async -> Result<QuoteDTO, Error> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: SwapTarget.quote(blockchain: blockchain, parameters: parameters)), decodeTo: QuoteDTO.self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func swap(blockchain: ExchangeBlockchain, parameters: SwapParameters) async -> Result<SwapDTO, Error> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: SwapTarget.swap(blockchain: blockchain, parameters: parameters)), decodeTo: SwapDTO.self)
                
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
