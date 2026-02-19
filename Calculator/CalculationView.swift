//
//  CalculationView.swift
//  Calculator
//
//  Created by Dare on 2/19/26.
//

import SwiftUI


struct CalculationView: View {
    var value: String
    
    var body: some View {
        Text(value)
            .padding()
            .font(.largeTitle)
            .truncationMode(.head)
            .frame(maxWidth: .infinity,
                   maxHeight: 100,
                   alignment: .trailing)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(20)
    }
}

#Preview {
    CalculationView(value: "12345")
}
