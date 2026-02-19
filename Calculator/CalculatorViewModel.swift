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
    
    private var firstOperand: Double?
    private var secondOperand: Double?
    private var currentOperator: ButtonType.Operation?
    
    func calculatorButtonPressed(_ buttonType: ButtonType) {
        switch buttonType {
        case .numeric(let value):
            switch value {
            case .toggleNegative:
                toggleNegative()
            case .decimalPoint:
                setDecimalPointIfNeeded()
            default:
                calculationResult += value.rawValue
            }
        case .function(let function):
            switch function {
            case .backspace:
                backspace()
            case .allClear:
                clear()
            case .percent:
                calculationResult = "\(resultPercentage())"
            }
            return
        case .operation(let operation):
            switch operation {
            case .equals:
                setSecondOperand()
                calculate()
            default :
                setFirstOperand()
                calculationResult = ""
                currentOperator = operation
            }
        }
    }
    
    func clear() {
        calculationResult = ""
        firstOperand = nil
        secondOperand = nil
    }
    
    func resultPercentage() -> Double {
        guard let value = Double(calculationResult) else {
            return 0
        }
        return value / 100
    }
    
    func toggleNegative() {
        if calculationResult.first == "-" {
            calculationResult.removeFirst()
        } else {
            calculationResult = "-\(calculationResult)"
        }
    }
    
    func setDecimalPointIfNeeded() {
        guard !calculationResult.contains(where: { $0 == "." }) else {
            return
        }
        calculationResult += "."
    }
    
    func backspace() {
        guard !calculationResult.isEmpty else {
            return
        }
        calculationResult.removeLast()
    }
    
    func setFirstOperand() {
        firstOperand = Double(calculationResult)
    }
    
    func setSecondOperand() {
        secondOperand = Double(calculationResult)
    }
    
    func calculate() {
        guard let currentOperator = currentOperator,
        let firstOperand = firstOperand,
        let secondOperand = secondOperand else {
            calculationResult = "Error"
            return
        }
        
        switch currentOperator {
        case .division:
            calculationResult = "\(firstOperand / secondOperand)"
        case .multiplication:
            calculationResult = "\(firstOperand * secondOperand)"
        case .subtraction:
            calculationResult = "\(firstOperand - secondOperand)"
        case .addition:
            calculationResult = "\(firstOperand + secondOperand)"
        case .equals:
            return
        }
        
        setFirstOperand()
        self.secondOperand = nil
        self.currentOperator = nil
    }
    
}
