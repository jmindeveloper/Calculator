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
    
    @IBInspectable var borderWidth: Bool = false {
        didSet {
            if borderWidth {
                self.layer.borderWidth = 0.3
                self.layer.borderColor = UIColor.lightGray.cgColor
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
    
    @IBInspectable var isShadow: Bool = false {
        didSet {
            if isShadow {
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOffset = CGSize(width: 2, height: 2)
                self.layer.shadowRadius = 2
                self.layer.shadowOpacity = 0.4
            }
        }
    }
    
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = 8
            }
        }
    }
}
