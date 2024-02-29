//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinData(_ data: CoinData)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "6F5AE21E-81D2-4288-838A-4058AD723C99"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        performRequest(with: currency)
    }
    
    /// Request Coin Data from URL
    func performRequest(with currency: String) {
        if let url = URL(string: "\(baseURL)/\(currency)?apikey=\(apiKey)") {
            // Make a url session to do a request task
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error!)
                }
                if let safeData = data {
                    let coinData = parseJson(safeData)
                    if let safeCoinData = coinData {
                        delegate?.didUpdateCoinData(safeCoinData)
                    }

                }
            }
            
            // Start doing the defined task
            task.resume()
        }
    }
    
    /// Decode Json to CoinData
    func parseJson(_ jsonData: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: jsonData)
            return decodedData
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }

    
}
