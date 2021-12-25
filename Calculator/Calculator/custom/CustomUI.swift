//
//  CustomUI.swift
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

class CustomView: UIView {
    @IBInspectable var borderWidth: Bool = false {
        didSet {
            if borderWidth {
                self.layer.borderWidth = 0.3
            }
        }
    }
}
