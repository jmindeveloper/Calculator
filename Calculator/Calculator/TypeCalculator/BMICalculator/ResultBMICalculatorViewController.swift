//
//  ResultBMICalculatorViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/31.
//

import UIKit

class ResultBMICalculatorViewController: UIViewController {
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var bmrLabel: UILabel!
    
    var obesity = ""
    var bmi: Double = 0
    var bmr: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiLabel.text = "\(bmi) (\(obesity))"
        bmrLabel.text = "\(bmr) kcal"
        
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
