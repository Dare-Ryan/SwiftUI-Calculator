//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Dare on 2/19/26.
//

import SwiftUI

struct CalculatorButton: View {
    let buttonType: ButtonType
    let onButtonTap: () -> Void
    
    var body: some View {
        Button {
            onButtonTap()
        } label: {
            Text(buttonType.text)
                .font(.title)
                .foregroundStyle(Color(.label))
                .frame(width: 60, height: 60)
                .background(buttonType.color)
                .cornerRadius(30)
        }
    }
}

#Preview {
    CalculatorButton(buttonType: .operation(.division)){
        print("Tapped")
    }
}
