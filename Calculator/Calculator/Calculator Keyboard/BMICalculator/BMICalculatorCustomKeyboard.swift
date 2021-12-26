//
//  BMICalculatorCustomKeyboard.swift
//  Calculator
//
//  Created by J_Min on 2021/12/26.
//

import UIKit

class BMICalculatorCustomKeyboard: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("키보드호출")
        setUpDynamicLayout()
        
    }
    
    private func setUpDynamicLayout() {
        let screenWidth = Int(UIScreen.main.bounds.size.width)
        let screenHeight = Int(UIScreen.main.bounds.size.height)
        
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
}
