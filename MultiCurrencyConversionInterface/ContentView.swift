//
//  ContentView.swift
//  MultiCurrencyConversionInterface
//
//  Created by John Kuan on 27/5/20.
//  Copyright © 2020 JohnKuan. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var viewModel: CurrencyConversionScreenViewModel
    
    init(viewModel: CurrencyConversionScreenViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Text("Currency Convertor")
                    .font(.largeTitle).padding()
                CurrencyConverterViewCard(amount: $viewModel.fromAmount, selectedKey: $viewModel.selectedFromCurrency, title: "From", options: viewModel.rates).zIndex(100)
                Text("Wallet Balance: \(viewModel.currentWalletBalanceLabel)")
                    .font(.body).padding(.leading).padding(.trailing)
                CurrencyConverterViewCard(amount: $viewModel.toAmount, selectedKey: $viewModel.selectedToCurrency, title: "To", options: viewModel.rates).zIndex(10)
                Text("Rate: \(viewModel.rateExchangeLabel)")
                    .font(.body).padding(.leading).padding(.trailing)
                Spacer()
                Button(action: {
                    print("convert")
                }) {
                    Text("Convert").fontWeight(.semibold)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45.0)
                .foregroundColor(.black)
                .background(ColorManager.coreUIColor)
                .cornerRadius(20)
                .padding(.all, 10)
                Button(action: {
                    print("View History")
                }) {
                    Text("View History").fontWeight(.semibold)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45.0)
                .foregroundColor(.black)
                .background(ColorManager.coreUIColor)
                .cornerRadius(20)
                .padding(.all, 10)
                Spacer()
            }
        }
        .padding()
    
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: CurrencyConversionScreenViewModel(webService: WebService()))
    }
}

