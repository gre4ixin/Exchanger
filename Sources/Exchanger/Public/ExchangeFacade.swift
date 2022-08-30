import Foundation

public protocol ExchangeFacade: AnyObject {
    /// Check status of service
    /// - Parameter blockchain: blockchain
    func healthCheck(blockchain: ExchangeBlockchain) async -> Result<HealthCheckDTO, ErrorDTO>
    
    /// blockchainID/tokens
    /// - Parameter blockchain: ExchangeBlockchain type
    /// - Returns: request result
    func tokens(blockchain: ExchangeBlockchain) async -> Result<InfoTokensDTO, ErrorDTO>
    func presents(blockchain: ExchangeBlockchain) async -> Result<PresentsConfigurationDTO, ErrorDTO>
    func liquiditySources(blockchain: ExchangeBlockchain) async -> Result<LiquiditySourcesDTO, ErrorDTO>
    
    /// Find best quote to exchange
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - parameters: parameters for exchange
    func quote(blockchain: ExchangeBlockchain, parameters: QuoteParameters) async -> Result<QuoteDTO, ErrorDTO>
    
    /// Generating data for exchange
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - parameters: parameters for exchange
    func swap(blockchain: ExchangeBlockchain, parameters: SwapParameters) async -> Result<SwapDTO, ErrorDTO>
    
    /// Address of the 1inch router that must be trusted to spend funds for the exchange
    /// - Parameter blockchain: blockchain type
    /// - Returns: parameters for exchange
    func spender(blockchain: ExchangeBlockchain) async -> Result<ApproveSpenderDTO, ErrorDTO>
    
    /// Generate data for calling the contract in order to allow the 1inch router to spend funds
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - approveTransactionParameters: parameters for exchange
    func approveTransaction(blockchain: ExchangeBlockchain, approveTransactionParameters: ApproveTransactionParameters) async -> Result<ApproveTransactionDTO, ErrorDTO>
    
    /// Get the number of tokens that the 1inch router is allowed to spend
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - allowanceParameters: parameters for exchange
    func allowance(blockchain: ExchangeBlockchain, allowanceParameters: ApproveAllowanceParameters) async -> Result<ApproveAllowanceDTO, ErrorDTO>
}

public class ExchangeService: ExchangeFacade {
    private let networkFacade: NetworkFacade = NetworkFacade()
    
    public func healthCheck(blockchain: ExchangeBlockchain) async -> Result<HealthCheckDTO, ErrorDTO> {
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
    
    public func tokens(blockchain: ExchangeBlockchain) async -> Result<InfoTokensDTO, ErrorDTO> {
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
    
    public func presents(blockchain: ExchangeBlockchain) async -> Result<PresentsConfigurationDTO, ErrorDTO> {
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
    
    public func liquiditySources(blockchain: ExchangeBlockchain) async -> Result<LiquiditySourcesDTO, ErrorDTO> {
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
    
    public func quote(blockchain: ExchangeBlockchain, parameters: QuoteParameters) async -> Result<QuoteDTO, ErrorDTO> {
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
    
    public func swap(blockchain: ExchangeBlockchain, parameters: SwapParameters) async -> Result<SwapDTO, ErrorDTO> {
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
    
    public func spender(blockchain: ExchangeBlockchain) async -> Result<ApproveSpenderDTO, ErrorDTO> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: InchApprove.spender(blockChain: blockchain)), decodeTo: ApproveSpenderDTO.self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func approveTransaction(blockchain: ExchangeBlockchain, approveTransactionParameters: ApproveTransactionParameters) async -> Result<ApproveTransactionDTO, ErrorDTO> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: InchApprove.transaction(blockChain: blockchain, params: approveTransactionParameters)), decodeTo: ApproveTransactionDTO.self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func allowance(blockchain: ExchangeBlockchain, allowanceParameters: ApproveAllowanceParameters) async -> Result<ApproveAllowanceDTO, ErrorDTO> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: DexTarget(target: InchApprove.allowance(blockChain: blockchain, params: allowanceParameters)), decodeTo: ApproveAllowanceDTO.self)
                
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
