//
//  CalculatorCodeBackup.swift
//  Calculator
//
//  Created by J_Min on 2021/12/20.
//

import Foundation

//for element in formula {
//
//    if element == "(" {
//        operatorStack.append("(")
//    } else if element == ")" {
//        while let opr = operatorStack.popLast() {
//            guard opr != "(" else { break }
//            numStack.append(opr)
//        }
//    } else if element == "×" || element == "÷" || element == "^" {
//        guard !operatorStack.isEmpty else { operatorStack.append(element); continue }
//
//        while let opr = operatorStack.last, (opr == "×" || opr == "÷" || opr == "^") {
//            numStack.append(operatorStack.popLast()!)
//        }
//        operatorStack.append(element)
//    } else if element == "+" || element == "−" {
//        guard !operatorStack.isEmpty else { operatorStack.append(element); continue }
//        while let opr = operatorStack.popLast() {
//            guard opr != "("  && opr != "+" && opr != "−" else {
//                if opr == "(" {
//                    operatorStack.append(opr)
//                    break
//                } else {
//                    numStack.append(opr)
//                    break
//                }
//            }
//            numStack.append(opr)
//        }
//
//        operatorStack.append(element)
//    } else {
//        numStack.append(element)
//    }
//}
