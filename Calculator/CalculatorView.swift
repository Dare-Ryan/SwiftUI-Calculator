//
//  ContentView.swift
//  Calculator
//
//  Created by Dare on 2/18/26.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject var viewModel = CalculatorViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CalculationView(value: viewModel.calculationResult)
                
                Divider()
                
                Spacer()
                
                LazyVGrid(columns: viewModel.numberRows, spacing: geometry.size.height * 0.05) {
                    ForEach(viewModel.buttons, id:\.self) { buttonType in
                            
                            CalculatorButton(buttonType: buttonType) {
                                viewModel.calculatorButtonPressed(buttonType)
                            }
                            
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
        }
        .padding()
    }
}

#Preview {
    CalculatorView()
}
