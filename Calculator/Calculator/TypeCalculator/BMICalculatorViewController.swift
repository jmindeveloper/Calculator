//
//  BMICalculatorViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/22.
//

import UIKit

class BMICalculatorViewController: UIViewController {
    
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        let BMICalculatorCustomKeyboard = Bundle.main.loadNibNamed("BMICalculatorCustomKeyboard", owner: nil, options: nil)
        guard let BMICalculatorKeyboard = BMICalculatorCustomKeyboard?.first as? BMICalculatorCustomKeyboard else { return }
        heightTextField.inputView = BMICalculatorKeyboard
        weightTextField.inputView = BMICalculatorKeyboard
        ageTextField.inputView = BMICalculatorKeyboard
        sexTextField.inputView = BMICalculatorKeyboard
        heightTextField.becomeFirstResponder()
        
        
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "BMI 계산기"
        
        let icon = UIImage(systemName: "line.horizontal.3")
        let item = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(showSideMenu))
        self.navigationItem.leftBarButtonItem = item
    }
    
    @objc func showSideMenu() {
        guard let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") else { return }
        self.present(sideMenuVC, animated: true, completion: nil)
    }
    
}
