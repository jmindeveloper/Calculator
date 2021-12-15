//
//  CalculatorCustomKeyboard.swift
//  Calculator
//
//  Created by J_Min on 2021/12/14.
//

import UIKit

protocol CalculatorKeyboardDelegate {
    func outPutData(_ str: String)
}

class CalculatorCustomKeyboard: UIView {
    
    var delegate: CalculatorKeyboardDelegate?
    
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
        delegate?.outPutData(num!)
        
    }
    
}



