//
//  ContentView.swift
//  WeSplit
//
//  Created by Yevhenii Burkovskyi on 11.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0;
    @State private var numberOfPeople = 2;
    @State private var tipPercentage = 20;
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0];
    
    var totalAmount: Double {
        let convertedTipPercentage = Double(tipPercentage);
        
        let tipAmount = checkAmount * convertedTipPercentage / 100
        
        return (checkAmount + tipAmount)
    }
    
    var totalPerPerson: Double {
        let convertedNumberOfPeople = Double(numberOfPeople + 2);
        let totalAmount = totalAmount
        
        return totalAmount/convertedNumberOfPeople
    }

    
    var body: some View {
        NavigationStack{
            
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)

                }
                Section{
                    Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(2 ..< 100) {
                        Text("\($0) people")
                    }
                }
                .pickerStyle(.navigationLink).navigationTitle("WeSplit").navigationBarTitleDisplayMode(.inline).toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
                Section("How much tip do you want to leave?"){
                    Picker("Tip", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Amount per person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total amount"){
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
