//
//  ResultGradeViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/25.
//

import UIKit

class ResultGradeViewController: UIViewController {
    
    @IBOutlet weak var fullMarkLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var totalGrade: Double = 0
    var applyGrade: Double = 0
    var majorTotalGrade: Double = 0
    var majorApplyTotalGrad: Double = 0
    var fullMark = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalGrade = round(totalGrade * 100) / 100
        majorTotalGrade = round(majorTotalGrade * 100) / 100
        
        fullMarkLabel.text = fullMark
        resultLabel.text = "총 평점: \(totalGrade) 전공평점: \(majorTotalGrade)\n이수학점: \(applyGrade) 전공이수학점: \(majorApplyTotalGrad)"
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
