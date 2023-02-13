//
//  ProductDetailModel.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 9/2/23.
//

import Foundation

struct Exchange: Codable {

    let exchangeType: [ExchangesTypes]
}

struct ExchangesTypes: Codable {

    let formatOne: String
    let formatTwo: String
    let operation: Double

    enum CodingKeys: String, CodingKey {
        case formatOne = "from"
        case formatTwo = "to"
        case operation = "rate"
    }
}

struct Transactions: Codable {

    let transactionProduct: [TransactionProduct]
}

struct TransactionProduct: Codable {

    let productCode: String
    let totalAmount: Double
    let currencyType: String

    enum CodingKeys: String, CodingKey {
        case productCode = "sku"
        case totalAmount = "amount"
        case currencyType = "currency"
    }
}
