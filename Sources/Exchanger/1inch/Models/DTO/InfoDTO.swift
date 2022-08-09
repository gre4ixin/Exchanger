//
//  File.swift
//  
//
//  Created by Pavel Grechikhin on 06.08.2022.
//

import Foundation

struct InfoTokensDTO: Decodable {
    let tokens: [String: TokenDTO]
}

// MARK: - Token
struct TokenDTO: Decodable {
    let symbol, name: String
    let decimals: Int
    let address: String
    let logoURI: String
    let tags: [TagDTO]
    let eip2612, isFoT: Bool?
    let domainVersion: String?
    let synth: Bool?
    let displayedSymbol: String?
}

enum TagDTO: String, Decodable {
    case native = "native"
    case pools = "pools"
    case savings = "savings"
    case tokens = "tokens"
}
