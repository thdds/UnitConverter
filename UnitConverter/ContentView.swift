//
//  ContentView.swift
//  UnitConverter
//
//  Created by Thaddäus Schima on 06.02.23.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var inputTempIsFocused: Bool
    @State private var inputTemperatur = 0.0
    private var test = Measurement(value: 0, unit: UnitTemperature.celsius)
    private var convertedValue: Double {
        if inputTempType == "ºC" {
            if outputTemperaturType == "F" {
                return inputTemperatur * 1.8 + 32
            } else if outputTemperaturType == "K" {
                return inputTemperatur + 273.15
            } else {
                return inputTemperatur
            }
        } else if inputTempType == "F" {
            if outputTemperaturType == "ºC" {
                return (inputTemperatur-32) * (5/9)
            } else if outputTemperaturType == "K" {
                return (inputTemperatur - 32) / 1.8 + 273.15
            } else {
                return inputTemperatur
            }
        } else { // Kelvin
            if outputTemperaturType == "ºC" {
                return inputTemperatur - 273.15
            } else if outputTemperaturType == "F" {
                return (inputTemperatur - 273.15) * 1.8 + 32
            } else {
                return inputTemperatur
            }
        }
    }
    @State private var outputTemperaturType = "F"
    @State private var inputTempType:String = "ºC"
    let conversionTemperatureTypes = ["ºC", "F", "K"]
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Your Temperatur: ", value: $inputTemperatur, format: .number).focused($inputTempIsFocused)
                        .keyboardType(.decimalPad)
                    Picker("Choose the temp type", selection: $inputTempType) {
                        ForEach(conversionTemperatureTypes, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Input your Temperatur and the type")
                }
                Section {
                    Picker("Choose your output Temp type", selection: $outputTemperaturType) {
                        ForEach(conversionTemperatureTypes, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Choose your output Temperatur")
                }
                Section {
                    Text(convertedValue, format: .number)
                } header: {
                    Text("Output Temperatur")
                }
            }
                .navigationTitle("Temperatur Converter")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()

                        Button("Done") {
                            inputTempIsFocused = false
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
