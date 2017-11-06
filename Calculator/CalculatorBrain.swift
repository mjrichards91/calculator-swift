//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Michael Richards on 11/3/17.
//  Copyright © 2017 Michael Richards. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private var descriptionValues: [String] = []
    
    private var accumulatorValue: String {
        get {
            return String(format: "%g", accumulator!)
        }
    }
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case powOperation(Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "−" : Operation.binaryOperation({ $0 - $1 }),
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "×" : Operation.binaryOperation({ $0 * $1 }),
        "e" : Operation.constant(M_E),
        "π" : Operation.constant(Double.pi),
        "tan" :  Operation.unaryOperation(tan),
        "√" : Operation.unaryOperation(sqrt),
        "sin" : Operation.unaryOperation(sin),
        "cos" : Operation.unaryOperation(cos),
        "x²" : Operation.powOperation(2),
        "±" : Operation.unaryOperation({ -$0 }),
        "=" : Operation.equals
    ]
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
                descriptionValues.append(symbol)
            case .unaryOperation(let function):
                if accumulator != nil {
                    descriptionValues.append("\(symbol)(\(descriptionValues.removeLast()))")
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    if resultIsPending {
                        performPendingBinaryOperation()
                    }
                    
                    descriptionValues.append(symbol)
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .powOperation(let value):
                if accumulator != nil {
                    accumulator = pow(accumulator!, value)
                }
            case .equals:
                // Reset the first element to the finalized caluculation
                descriptionValues = [description]
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if resultIsPending && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
        
        if descriptionValues.count == 1 {
            descriptionValues = [accumulatorValue]
        } else {
            descriptionValues.append(accumulatorValue)
        }
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    var resultIsPending: Bool {
        get {
            return pendingBinaryOperation != nil
        }
    }
    
    var description: String {
        get {
            return descriptionValues.joined()
        }
    }
}
