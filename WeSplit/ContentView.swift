//
//  ContentView.swift
//  WeSplit
//
//  Created by Joel Martinez on 8/30/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 50.0
    @State private var splitParties = 2
    @State private var tipPercentage = 15
    @FocusState private var checkAmountIsFocused: Bool
    
    let tips = [0,10,15,20,25]
    
    var currencyFormatter: NumberFormatter {
        get {
            let formatter = NumberFormatter()
            formatter.currencyCode = Locale.current.currencyCode ?? "EUR"
            formatter.numberStyle = .currency
            return formatter
        }
    }
    
    private var totalCheck: Double {
        get {
            checkAmount * (1.0 + Double(tipPercentage)/100.0)
        }
    }
    
    private var totalPerParty: Double {
        get {
            totalCheck / Double(splitParties)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currencyCode ?? "EUR"))
                            .keyboardType(.decimalPad)
                            .focused($checkAmountIsFocused)
                    VStack(alignment: .leading) {
                        Text("Tip percentage:")
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tips, id:\.self) {
                                Text("\($0)%")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                } header: {
                    Text("Check amount")
                } footer: {
                    Text("Total check including tip \(currencyFormatter.string(from: NSNumber(value: totalCheck))!)")
                }
                
                Section("Split check") {
                    Picker("Parties", selection: $splitParties) {
                        ForEach(2...25, id:\.self) {
                            Text("\($0) parties")
                        }
                    }
                    Text("Each party pays \(currencyFormatter.string(from: NSNumber(value: totalPerParty))!)")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        checkAmountIsFocused = false
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
