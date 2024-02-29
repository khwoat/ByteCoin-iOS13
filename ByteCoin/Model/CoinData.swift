//
//  CoinData.swift
//  ByteCoin
//
//  Created by IT-HW05011-00224 on 9/2/2567 BE.
//  Copyright © 2567 BE The App Brewery. All rights reserved.
//

import Foundation

class CoinData: Codable {
    let rate: Double
    let assetIdBase: String
    let assetIdQuote: String
    
    // Make custom CodingKeys
    private enum CodingKeys : String, CodingKey {
        case rate, assetIdBase = "asset_id_base", assetIdQuote = "asset_id_quote"
    }
}
