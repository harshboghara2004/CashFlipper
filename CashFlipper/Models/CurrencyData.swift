//
//  CurrencyData.swift
//  CashFlipper
//
//  Created by Boghara on 01/10/23.
//

import Foundation

var currencyControl = CurrencyManager()

let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

struct CurrencyData: Codable {
    let data: Currency
}

struct Currency: Codable {
    let AUD: Details
    let BRL: Details
    let CAD: Details
    let CNY: Details
    let EUR: Details
    let GBP: Details
    let HKD: Details
    let IDR: Details
    let ILS: Details
    let INR: Details
    let JPY: Details
    let MXN: Details
    let NOK: Details
    let NZD: Details
    let PLN: Details
    let RON: Details
    let RUB: Details
    let SEK: Details
    let SGD: Details
    let USD: Details
    let ZAR: Details
}

struct Details: Codable {
    let value: Double
}
