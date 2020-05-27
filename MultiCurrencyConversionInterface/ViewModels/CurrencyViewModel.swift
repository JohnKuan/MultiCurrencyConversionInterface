//
//  CurrencyViewModel.swift
//  MultiCurrencyConversionInterface
//
//  Created by John Kuan on 27/5/20.
//  Copyright © 2020 JohnKuan. All rights reserved.
//

import Foundation
import SwiftUI

class CurrencyViewModel: Identifiable {
    
    let id = UUID()
    
    let currencyRate: CurrencyRateResponse
    
    
    init(currencyRate: CurrencyRateResponse) {
        self.currencyRate = currencyRate
    }
    
    var base: String {
        return self.currencyRate.base
    }
    
    var date: String {
        return self.currencyRate.date
    }
    
    var rates: Dictionary<String, Double> {
        return self.currencyRate.rates
    }
}
