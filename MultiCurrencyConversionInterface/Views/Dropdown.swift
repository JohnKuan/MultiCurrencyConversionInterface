//
//  Dropdown.swift
//  MultiCurrencyConversionInterface
//
//  Created by John Kuan on 27/5/20.
//  Copyright © 2020 JohnKuan. All rights reserved.
//

import SwiftUI

let dropdownCornerRadius: CGFloat = 8.0

struct Dropdown: View {
    var dropdownWidth:CGFloat = 150
    var options: [DropdownOption]
    
    @Binding var selectedKey: String
    @Binding var shouldShowDropdown: Bool
    @Binding var displayText: String

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true){
                
                ForEach(self.options, id: \.self) { option in
                    DropdownOptionElement(dropdownWidth: self.dropdownWidth, val: option.val, key: option.key, selectedKey: self.$selectedKey, shouldShowDropdown: self.$shouldShowDropdown, displayText: self.$displayText)
                }
                
            }.frame(minWidth: 100, idealWidth: 100, maxWidth: 120, minHeight: 150, maxHeight: 200, alignment: .center)
            .background(Color.white)
            .cornerRadius(dropdownCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: dropdownCornerRadius)
                    .stroke(ColorManager.coreUIColor, lineWidth: 1))
        
    }
}

struct DropdownButton_Previews: PreviewProvider {
    static let options = [
        DropdownOption(key: "week", val: "This week"), DropdownOption(key: "month", val: "This month"), DropdownOption(key: "year", val: "This year")
    ]

    static var previews: some View {
        Group {
            VStack(alignment: .leading) {
                DropdownButton(displayText: "This month", selectedKey: .constant("Test"), options: options)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green)
            .foregroundColor(Color.primary)

            VStack(alignment: .leading) {

                DropdownButton(shouldShowDropdown: true, displayText: "This month", selectedKey: .constant("Test"), options: options)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green)
            .foregroundColor(Color.primary)
        }
    }
}


struct DropdownButton: View {
    var dropdownWidth:CGFloat = 300
    @State var shouldShowDropdown = false
    @State var displayText: String
    @Binding var selectedKey: String
    var options: [DropdownOption]

    let buttonHeight: CGFloat = 30
    var body: some View {
        Button(action: {
            self.shouldShowDropdown.toggle()
        }) {
            HStack {
                Text(displayText).foregroundColor(ColorManager.coreUISecondaryColor)
                Spacer()
                    .frame(width: 20)
                Image(systemName: self.shouldShowDropdown ? "chevron.up" : "chevron.down").foregroundColor(ColorManager.coreUISecondaryColor)
            }
        }
        .padding(.horizontal)
        .cornerRadius(dropdownCornerRadius)
        .frame(height: self.buttonHeight)
        .overlay(
            RoundedRectangle(cornerRadius: dropdownCornerRadius)
                .stroke(ColorManager.coreUIColor, lineWidth: 1)
        )
        .overlay(
            VStack {
                if self.shouldShowDropdown {
                    Spacer(minLength: buttonHeight + 10)
                    Dropdown(dropdownWidth: dropdownWidth, options: self.options, selectedKey: self.$selectedKey, shouldShowDropdown: $shouldShowDropdown, displayText: $displayText).zIndex(100)
                }
            
            }
        , alignment: .topLeading
        )
        .background(
            RoundedRectangle(cornerRadius: dropdownCornerRadius).fill(Color.white)
        )
            
    }
}



struct DropdownOption: Hashable {
    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }

    var key: String
    var val: String
}

struct DropdownOptionElement: View {
    var dropdownWidth:CGFloat = 150
    var val: String
    var key: String
    @Binding var selectedKey: String
    @Binding var shouldShowDropdown: Bool
    @Binding var displayText: String

    var body: some View {
        VStack {
            Text(self.val)
                .foregroundColor(ColorManager.coreUISecondaryColor)
                .onTapGesture {
                    self.shouldShowDropdown = false
                    self.displayText = self.val
                    self.selectedKey = self.key
                }
            Divider().foregroundColor(Color.gray)
        }.padding(.top, 15)
        .background(Color.white).frame(width: dropdownWidth, height: 30)

    }
}
