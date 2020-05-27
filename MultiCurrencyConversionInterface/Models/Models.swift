//
//  Models.swift
//  MultiCurrencyConversionInterface
//
//  Created by John Kuan on 27/5/20.
//  Copyright © 2020 JohnKuan. All rights reserved.
//

import Foundation


struct CurrencyRateResponse : Codable {
    let base: String
    let date: String
    let rates: Dictionary<String, Double>
}
