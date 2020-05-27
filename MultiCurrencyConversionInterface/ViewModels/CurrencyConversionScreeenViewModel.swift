//
//  CurrencyConversionScreeenViewModel.swift
//  MultiCurrencyConversionInterface
//
//  Created by John Kuan on 27/5/20.
//  Copyright © 2020 JohnKuan. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class CurrencyConversionScreenViewModel : ObservableObject {
    
    let defaultWalletBalance : Double = 1500.50
    let baseCurrency = "SGD"
    var currentWalletBalance:  Double  {
        return defaultWalletBalance
    }
    
    var currentWalletBalanceLabel: String {
        return String(format: "%.2f", currentWalletBalance)
    }
    
    private(set) var rateExchange: Double = 0
    var rateExchangeLabel : String {
        if(selectedFromCurrency.isEmpty || selectedToCurrency.isEmpty) {return ""}
        return selectedFromCurrency + "1" + " to " + selectedToCurrency + String(format: "%.2f", rateExchange)
    }
    
    @Published var selectedFromCurrency: String = "" {
        didSet {
            print(selectedFromCurrency)
            requestExchangeRate()
        }
    }
    @Published var fromAmount: String = "" {
        didSet {
            print(fromAmount)
        }
    }
    @Published var selectedToCurrency: String = "" {
        didSet {
            print(selectedToCurrency)
            requestExchangeRate()
        }
    }
    @Published var toAmount: String = ""
    @Published var dataSource: CurrencyViewModel?
    
    var rates: [DropdownOption] {
        guard let dataSource = dataSource else {
            return []
        }
        return dataSource.rates.map { (key: String, value: Double) -> DropdownOption in
            return DropdownOption(key: key, val: key)
        }.sorted { (a, b) -> Bool in
            a.key<b.key
        }
    }
    
    private let webService: IWebService
    private var disposables = Set<AnyCancellable>()
    
    init(webService: IWebService) {
        self.webService = webService
        refresh()
        
    }
    
    func refresh() {
        self.webService.loadCurrencyRatesWithBase {
            (response) in
            guard let res = response else {
                return
            }
            self.dataSource = CurrencyViewModel(currencyRate: res)
        }
    }
    
    func calculateCurrencyExchange() -> Double {
        return 0
    }
    
    func requestExchangeRate() {
        self.webService.loadCurrencyRateWithFromAndToSelected(from: selectedFromCurrency, to: selectedToCurrency) {
            (response) in
            guard let res = response, let rateEx = res.rates[self.selectedToCurrency]else {
                return
            }
            self.rateExchange = rateEx
        }
    }
    
}
