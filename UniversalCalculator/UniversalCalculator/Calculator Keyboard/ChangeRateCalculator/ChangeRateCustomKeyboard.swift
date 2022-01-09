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
    
    @IBAction func numPad(_ sender: UIButton) {
        let num = sender.titleLabel?.text
        changeRateDelegate?.numPad(num!)
    }
    
    @IBAction func dotPad(_ sender: UIButton) {
        changeRateDelegate?.dotPad(".")
    }
    
    @IBAction func deletePad(_ sender: UIButton) {
        changeRateDelegate?.deletePad()
    }
}
