//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Michael Quintero on 6/12/15.
//  Copyright (c) 2015 Michael Quintero. All rights reserved.
//

import Foundation

class CalculatorBrain{
    //private enum Op : Printable{
    private enum Op{
        case Operand(Double)
        case UnaryOperation(String, Double ->Double)
        case BinaryOperation(String,(Double, Double)->Double)
        
//        var description : String {
//            get{
//                switch self{
//                case .Operand(let operand,_ ):
//                    return "\(operand)"
//                case .UnaryOperation(let symbol, _):
//                    return symbol
//                case .BinaryOperation(let symbol,_):
//                    return symbol
//                }
//
//            }
//        }
    }
    
    private var opStack = [Op]()
    private var knownOps = [String: Op]()
    
    init(){
        func learnOp(op:Op){
            //knownOps[op.description] = op
            knownOps[op.#1] = op
        }
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷",{$1 / $0}))
        learnOp(Op.BinaryOperation("+",+))
        learnOp(Op.BinaryOperation("−",{$1 - $0}))
        learnOp(Op.UnaryOperation("√", sqrt))

        
    }
    //Evaluate the opstack
    private func evaluate(ops: [Op]) -> (result: Double?,remainingOps:[Op]){
        if !ops.isEmpty{
            //remaining operations to complete
            var remainingOps = ops
            let op = remainingOps.removeLast()
            //perform the operation recursively
            switch op{
            case .Operand(let operand):
                return (operand,remainingOps)
            case .UnaryOperation(_,let operation):
                let operandEvaluaton = evaluate(remainingOps)
                if let operand = operandEvaluaton.result{
                    return (operation(operand),operandEvaluaton.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evalutation = evaluate(remainingOps)
                if let operand1 = op1Evalutation.result {
                    let op2Evaluation = evaluate(op1Evalutation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1, operand2) , op2Evaluation.remainingOps)
                    }
                }
            }
        }
      return (nil,ops)
    }
  
    func evaluate()->Double?{
        let (result,remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
        }
    func pushOperand(operand:Double) -> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
        
    func performOperation(symbol:String) -> Double?{
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
}