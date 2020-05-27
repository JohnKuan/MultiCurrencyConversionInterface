//
//  CurrencyConverterViewCard.swift
//  MultiCurrencyConversionInterface
//
//  Created by John Kuan on 27/5/20.
//  Copyright © 2020 JohnKuan. All rights reserved.
//

import SwiftUI

struct CurrencyConverterViewCard: View {
    @Binding var amount: String
    @Binding var selectedKey: String
    var title: String
    var options: [DropdownOption]
    static let defaultOptions = [
        DropdownOption(key: "SGD", val: "SGD"), DropdownOption(key: "USD", val: "USD"), DropdownOption(key: "JPY", val: "JPY"),  DropdownOption(key: "EUR", val: "EUR")
    ]
    var body: some View {
        VStack (alignment: .leading) {
            Text(title).font(.subheadline)
            HStack {
                DropdownButton(dropdownWidth: 120, displayText: "$", selectedKey: $selectedKey, options: options).zIndex(10)
                Spacer(minLength: 15.0)
                TextField("e.g. 1000", text: $amount).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }.padding()
        
    }
}

struct CurrencyConverterViewCard_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyConverterViewCard(amount: .constant("Test"), selectedKey: .constant("SGD"), title: "test", options: CurrencyConverterViewCard.defaultOptions)
    }
}
