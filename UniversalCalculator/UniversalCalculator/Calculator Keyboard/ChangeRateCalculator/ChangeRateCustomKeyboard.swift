//
//  ChangeRateCustomKeyboard.swift
//  Calculator
//
//  Created by J_Min on 2022/01/01.
//

import UIKit

protocol ChangeRateDelegate {
    func numPad(_ num: String)
    func dotPad(_ dot: String)
    func deletePad()
}

class ChangeRateCustomKeyboard: UIView {
    
    var changeRateDelegate: ChangeRateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var numPadClosure: ((String) -> (Void))?
    var dotPadClosure: ((String) -> (Void))?
    var deletePadClosure: (() -> ())?
    
    @IBAction func numPad(_ sender: UIButton) {
        let num = sender.titleLabel?.text
        changeRateDelegate?.numPad(num!)
        numPadClosure?(num!)
    }
    
    @IBAction func dotPad(_ sender: UIButton) {
        changeRateDelegate?.dotPad(".")
        dotPadClosure?(".")
    }
    
    @IBAction func deletePad(_ sender: UIButton) {
        changeRateDelegate?.deletePad()
        deletePadClosure?()
    }
}
