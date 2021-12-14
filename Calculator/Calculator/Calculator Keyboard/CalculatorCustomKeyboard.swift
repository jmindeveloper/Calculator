//
//  CalculatorCustomKeyboard.swift
//  Calculator
//
//  Created by J_Min on 2021/12/14.
//

import UIKit

class CalculatorCustomKeyboard: UIView {
    
    @IBOutlet weak var keyboardStack: UIStackView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpDynamicLayout()
        
    }
    
    private func setUpDynamicLayout() {
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        keyboardStack.translatesAutoresizingMaskIntoConstraints = true
        keyboardStack.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        keyboardStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        keyboardStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        keyboardStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
//        
    }
    

}
