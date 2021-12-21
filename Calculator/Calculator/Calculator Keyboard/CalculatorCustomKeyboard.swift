//
//  CalculatorCustomKeyboard.swift
//  Calculator
//
//  Created by J_Min on 2021/12/14.
//

import UIKit

protocol NumPadDelegate {
    func numData(_ str: String)
}

protocol DotKeyDelegate {
    func dotData(_ dot: String)
}

protocol OperatorKeyDelegate {
    func operatorData(_ operatorKey: String)
}

protocol ParenthesisDelegate {
    func parenthesis()
}

protocol EqualDelegate {
    func equalKey()
}

protocol ClearDelegata {
    func clearKey()
}

class CalculatorCustomKeyboard: UIView {
    
    var numPadDelegate: NumPadDelegate?
    var dotKeyDelegate: DotKeyDelegate?
    var operatorKeyDelegate: OperatorKeyDelegate?
    var parenthesisDelegate: ParenthesisDelegate?
    var equalDelegate: EqualDelegate?
    var clearDelegate: ClearDelegata?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpDynamicLayout()
    }
    
    private func setUpDynamicLayout() {
//        self.translatesAutoresizingMaskIntoConstraints = false
        let screenHeight = Int(UIScreen.main.bounds.size.height)
        let screenWidth = Int(UIScreen.main.bounds.size.width)
        print("screenHeight --> \(screenHeight)")
        
        if screenHeight >= 926 {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight -  370)
            print("iphone 13 proMax")
        } else if screenHeight < 926 && screenHeight >= 844 {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight -  370)
            print("iphone 12")
        } else if screenHeight < 844 && screenHeight >= 736 {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight -  340)
            print("iphone 8 plus")
        } else if screenHeight < 736 && screenHeight >= 667 {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 340)
            print("iphone 8")
        } else {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 340)
            print("iphone se2")
        }
    }
    
    // 숫자키
    @IBAction func numPad(_ sender: UIButton) {
        let num = sender.titleLabel?.text
        numPadDelegate?.numData(num!)
        
    }
    
    // dot키
    @IBAction func dotKey(_ sender: UIButton) {
        dotKeyDelegate?.dotData(".")
    }
    
    //연산자키
    @IBAction func operatorKey(_ sender: UIButton) {
        let operatorString: String!
        
        switch sender.titleLabel!.text {
        case nil:
            operatorString = "÷"
        case "X":
            operatorString = "×"
        case "-":
            operatorString = "−"
        case "+":
            operatorString = "+"
        default:
            operatorString = sender.titleLabel!.text!
        }
        
        print(operatorString!)
        operatorKeyDelegate?.operatorData(operatorString!)
    }
    
    @IBAction func parenthesisKey(_ sender: UIButton) {
        parenthesisDelegate?.parenthesis()
    }
    
    @IBAction func equalKey(_ sender: UIButton) {
        equalDelegate?.equalKey()
    }
    
    @IBAction func clearKey(_ sender: Any) {
        clearDelegate?.clearKey()
    }
}



