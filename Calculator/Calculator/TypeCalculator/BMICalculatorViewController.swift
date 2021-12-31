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
        
        BMICalculatorKeyboard.bmiDelegate = self
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
    
    func bmiCalculator(_ height: Double, _ weight: Double, _ age: Double, _ isMan: Bool) -> (String, Double, Double) {
        var obesity = ""
        var bmr: Double = 0
        let bmi: Double = weight / ((height / 100) * (height / 100))
        
        switch bmi {
        case 0...18.5:
            obesity = "저체중"
        case 18.6..<23:
            obesity = "정상체중"
        case 23..<25:
            obesity = "과체중"
        case 25..<30:
            obesity = "중도비만"
        case 30...:
            obesity = "중등도비만"
        default:
            break
        }
        
        if isMan {
            bmr = 66 + (13.8 * weight) + (5 * height) - (6.8 * age)
        } else {
            bmr = 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age)
        }
        
        return (obesity, bmi, bmr)
    }
    
    @IBAction func calculatorBtn(_ sender: Any) {
        let height = Double(heightTextField.text!)!
        let weight = Double(weightTextField.text!)!
        let age = Double(ageTextField.text!)!
        let isMan = { () -> Bool in
            if self.sexTextField.text! == "남성" {
                return true
            } else {
                return false
            }
        }
        
        let obesity = bmiCalculator(height, weight, age, isMan()).0
        var bmi = bmiCalculator(height, weight, age, isMan()).1
        bmi = round(bmi * 100) / 100
        var bmr = bmiCalculator(height, weight, age, isMan()).2
        bmr = round(bmr * 100) / 100
        print(obesity)
        print(bmi)
        print(bmr)
        
    }
}

extension BMICalculatorViewController: BMIDelegate {
    // MARK: 숫자
    func bmiNumData(_ num: String) {
        if heightTextField.isFirstResponder {
            heightTextField.text?.append(num)
        } else if weightTextField.isFirstResponder {
            weightTextField.text?.append(num)
        } else if ageTextField.isFirstResponder {
            ageTextField.text?.append(num)
        }
    }
    
    // MARK: 성별
    func bmiSexData(_ sex: String) {
        if sex == "남성" {
            sexTextField.text = "남성"
        } else {
            sexTextField.text = "여성"
        }
    }
    
    // MARK: dot
    func bmiDotData(_ dot: String) {
        if heightTextField.isFirstResponder {
            let heightText = heightTextField.text!
            heightTextField.text = self.dot(heightText)
        } else if weightTextField.isFirstResponder {
            let weightText = weightTextField.text!
            weightTextField.text = self.dot(weightText)
        }
    }
    
    func dot(_ text: String) -> String {
        var text = text
        if !text.contains(".") && !text.isEmpty {
            text.append(".")
        }
        return text
    }
    
    // MARK: delete
    func bmiDelete() {
        if heightTextField.isFirstResponder {
            guard !heightTextField.text!.isEmpty else { return }
            heightTextField.text?.removeLast()
        } else if weightTextField.isFirstResponder {
            guard !weightTextField.text!.isEmpty else { return }
            weightTextField.text?.removeLast()
        } else if ageTextField.isFirstResponder {
            guard !ageTextField.text!.isEmpty else { return }
            ageTextField.text?.removeLast()
        }
    }
    
}
