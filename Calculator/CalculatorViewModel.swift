//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Dare on 2/19/26.
//

//import Foundation
import Combine
import SwiftUI

enum ButtonType: Hashable {
    case function(Function)
    case numeric(Numeric)
    case operation(Operation)
    
    
    enum Function: String {
        case backspace = "⌫"
        case allClear = "AC"
        case percent = "%"
    }
    
    enum Numeric: String {
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case zero = "0"
        case toggleNegative = "⁺/₋"
        case decimalPoint = "."
    }
    
    enum Operation: String {
        case division = "÷"
        case multiplication = "×"
        case subtraction = "−"
        case addition = "+"
        case equals = "="
    }
    
    var text: String {
        switch self {
        case .function(let function):
            return function.rawValue
        case .numeric(let numeric):
            return numeric.rawValue
        case .operation(let operation):
            return operation.rawValue
        }
    }
    
    var color: Color {
        switch self {
        case .function(_):
            return Color(.systemGray)
        case .numeric(_):
            return Color(.secondarySystemBackground)
        case .operation(_):
            return Color(.systemOrange)
        }
    }
}

final class CalculatorViewModel: ObservableObject {
    @Published private(set) var calculationResult = ""
    
    let numberRows = Array(repeating: GridItem(), count: 4)
    let buttons = [
        ButtonType.function(.backspace),
        ButtonType.function(.allClear),
        ButtonType.function(.percent),
        ButtonType.operation(.division),
        ButtonType.numeric(.seven),
        ButtonType.numeric(.eight),
        ButtonType.numeric(.nine),
        ButtonType.operation(.multiplication),
        ButtonType.numeric(.four),
        ButtonType.numeric(.five),
        ButtonType.numeric(.six),
        ButtonType.operation(.subtraction),
        ButtonType.numeric(.one),
        ButtonType.numeric(.two),
        ButtonType.numeric(.three),
        ButtonType.operation(.addition),
        ButtonType.numeric(.toggleNegative),
        ButtonType.numeric(.zero),
        ButtonType.numeric(.decimalPoint),
        ButtonType.operation(.equals)
    ]
    
    private var firstOperand: Int?
    private var secondOperand: Int?
    
    
    func calculatorButtonPressed(_ buttonType: ButtonType) {
        switch buttonType {
        case .numeric(_):
            calculationResult += buttonType.text
        case .function(_):
            return
        case .operation(_):
            return
        }
        
        
    }
    
}
