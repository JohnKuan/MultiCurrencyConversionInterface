//
//  WebService.swift
//  MultiCurrencyConversionInterface
//
//  Created by John Kuan on 27/5/20.
//  Copyright © 2020 JohnKuan. All rights reserved.
//

import Foundation

protocol IWebService {
    func loadCurrencyRateWithFromAndToSelected(from: String, to: String, completion: @escaping (CurrencyRateResponse?) -> ())
    func loadCurrencyRatesWithBase(completion: @escaping (CurrencyRateResponse?) -> ())
    func loadCurrencyRates(urlString: String, completion: @escaping (CurrencyRateResponse?) -> ())
}

class WebService : IWebService {
    static let exchangeURL: String = "https://api.exchangeratesapi.io/latest"
    
    func loadCurrencyRateWithFromAndToSelected(from: String, to: String, completion: @escaping (CurrencyRateResponse?) -> ()) {
        let urlString = WebService.exchangeURL + "?base=" + from + "&symbols=" + to
        loadCurrencyRates(urlString: urlString, completion: completion)
    }
    
    func loadCurrencyRatesWithBase(completion: @escaping (CurrencyRateResponse?) -> ()) {
        let urlString = WebService.exchangeURL + "?base=SGD"
        loadCurrencyRates(urlString: urlString, completion: completion)
    }
    
    func loadCurrencyRates(urlString: String, completion: @escaping (CurrencyRateResponse?) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let response = try? JSONDecoder().decode(CurrencyRateResponse.self, from: data)
            guard let res = response else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(res)
            }
            
            
        }.resume()
    }
}
