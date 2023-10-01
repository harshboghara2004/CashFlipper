//
//  CurrencyManager.swift
//  CashFlipper
//
//  Created by Boghara on 30/09/23.
//

import Foundation

protocol CurrencyManagerDelegate {
    func didUpdateCurrencyValue(currencyManager: CurrencyManager, currency: CurrencyModel)
    func didFailWithCurrency(error: Error)
}

struct CurrencyManager {
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var fromCur: String? = "USD"
    var toCur: String? = "INR"
    let baseURL = "https://api.currencyapi.com/v3/latest"
    let apikey = "cur_live_WkFSXORlExCnXxiMP4sbD0RAx8aFyangg898S9yA"
    
    var delegate: CurrencyManagerDelegate?
    
    func calculate() {
        let urlString = "\(baseURL)?apikey=\(apikey)"
        performRequest(with: urlString)
    }
   
    func getRate(_ str:String, _ dd: CurrencyData) -> Double {
        switch str {
            case "AUD":
                return dd.data.AUD.value
            case "BRL":
                return dd.data.BRL.value
            case "CAD":
                return dd.data.CAD.value
            case "CNY":
                return dd.data.CNY.value
            case "EUR":
                return dd.data.EUR.value
            case "GBP":
                return dd.data.GBP.value
            case "HKD":
                return dd.data.HKD.value
            case "IDR":
                return dd.data.IDR.value
            case "ILS":
                return dd.data.ILS.value
            case "INR":
                return dd.data.INR.value
            case "JPY":
                return dd.data.JPY.value
            case "MXN":
                return dd.data.MXN.value
            case "NOK":
                return dd.data.NOK.value
            case "NZD":
                return dd.data.NZD.value
            case "PLN":
                return dd.data.PLN.value
            case "RON":
                return dd.data.RON.value
            case "RUB":
                return dd.data.RUB.value
            case "SEK":
                return dd.data.SEK.value
            case "SGD":
                return dd.data.SGD.value
            case "USD":
                return dd.data.USD.value
            case "ZAR":
                return dd.data.ZAR.value
            default:
                return 0.0
        }
    }
    
    
    func performRequest(with urlString: String) {
        
        print(urlString)
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithCurrency(error: error!)
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let currency = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCurrencyValue(currencyManager: self, currency: currency)
                        print("1\(currency.fromCurrency) = \(currency.rate) \(currency.toCurrency)")
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ currencyData: Data) -> CurrencyModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
            let rate1: Double = getRate(fromCur!, decodedData)
            let rate2: Double = getRate(toCur!, decodedData)
            
            let currency = CurrencyModel(fromCurrency: fromCur!, toCurrency: toCur!, rate: rate2/rate1)
            return currency
            
        } catch {
            self.delegate?.didFailWithCurrency(error: error)
            return nil
        }
    }
    
    
}
