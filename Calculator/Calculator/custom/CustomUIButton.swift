//
//  CustomUIButton.swift
//  Calculator
//
//  Created by J_Min on 2021/12/12.
//

import UIKit

@IBDesignable
class CustomUIButton: UIButton {
    
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = 8
            }
        }
    }
    
}
