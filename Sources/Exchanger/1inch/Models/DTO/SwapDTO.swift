//
//  File.swift
//  
//
//  Created by Pavel Grechikhin on 09.08.2022.
//

import Foundation

struct QuoteDTO: Decodable {
    let fromToken, toToken: Token
    let toTokenAmount, fromTokenAmount: String
    let protocols: [ProtocolElement]
    let estimatedGas: Int
}

struct Token: Decodable {
    let symbol, name, address: String
    let decimals: Int
    let logoURI: String
}

struct ProtocolElement: Decodable {
    let name: String
    let part: Int
    let fromTokenAddress, toTokenAddress: String
}

struct SwapDTO: Decodable {
    let fromToken, toToken: SwapTokenDTO
    let toTokenAmount, fromTokenAmount: String
//    let protocols: [[[ProtocolElement]]]
    let tx: Tx
}

struct SwapTokenDTO: Decodable {
    let symbol, name: String
    let decimals: Int
    let address: String
    let logoURI: String
    let tags: [String]
}

struct Tx: Codable {
    let from, to, data, value: String
    let gas: Int
    let gasPrice: String
}

