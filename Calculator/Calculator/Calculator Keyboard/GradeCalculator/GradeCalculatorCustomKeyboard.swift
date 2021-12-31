//
//  GradeCalculatorCustomKeyboard.swift
//  Calculator
//
//  Created by J_Min on 2021/12/22.
//

import UIKit

//protocol GradeBtnDelegate {
//    func gradeData(_ str: String)
//}

class GradeCalculatorCustomKeyboard: UIView {
    
//    var gradeBtnDelegate: GradeBtnDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpDynamicLayout()
        
    }
    
    private func setUpDynamicLayout() {
        let screenHeight = Int(UIScreen.main.bounds.size.height)
        let screenWidth = Int(UIScreen.main.bounds.size.width)
//        print("screenHeight --> \(screenHeight)")
        
        if screenHeight >= 926 {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight -  570)
//            print("iphone 13 proMax")
        } else if screenHeight < 926 && screenHeight >= 844 {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight -  570)
//            print("iphone 12")
        } else if screenHeight < 844 && screenHeight >= 736 {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight -  540)
//            print("iphone 8 plus")
        } else if screenHeight < 736 && screenHeight >= 667 {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 540)
//            print("iphone 8")
        } else {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 540)
//            print("iphone se2")
        }
    }

    
    var gradeClosure: ((String) -> (Void))?
    var scoreClosure: ((String) -> (Void))?
    @IBAction func gradeBtn(_ sender: UIButton) {
        let num = sender.titleLabel?.text
        gradeClosure?(num!)
        
    }
    
    @IBAction func scoreBtn(_ sender: UIButton) {
        let score = sender.titleLabel?.text
        scoreClosure?(score!)
    }
    
}
