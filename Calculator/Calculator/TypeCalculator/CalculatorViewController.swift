//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/12.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var calculationFormula: UITextView!
    
    var formula = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        
        customKeyPad()
        calculationFormula.becomeFirstResponder()
        
    }
    
    func customKeyPad() {
        // nib 불러오기
        let calculatorCustomKeyboard = Bundle.main.loadNibNamed("CalculatorCustomKeyboard", owner: nil, options: nil)
        // CalculatorCustomKeyboard로 다운캐스팅
        guard let calculatorKeyboard = calculatorCustomKeyboard?.first as? CalculatorCustomKeyboard else { return }
        // inputView = calculatorKeyboard
        calculationFormula.inputView = calculatorKeyboard
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "일반계산기"
        
        let icon = UIImage(systemName: "line.horizontal.3")
        let item = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(showSideMenu))
        self.navigationItem.leftBarButtonItem = item
    }
    
    @objc func showSideMenu() {
        guard let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") else { return }
        self.present(sideMenuVC, animated: true, completion: nil)
    }

//    @IBAction func tapNumBtn(_ sender: UIButton) {
//        print(sender.titleLabel!.text!)
//        
//        let num = sender.titleLabel!.text!
//        
//        // formula가 0일때 (초기에 CalculationFormula == 0)
//        if formula == "0" {
//            // 버튼클릭시 formula "" 로 초기화
//            formula = ""
//            // "00" 이 들어왔을때
//            if num == "00" {
//                // formula = 0, return (CalculationFormula이 0으로만 이루어지는 경우 없음)
//                formula = "0"
//                return
//            }
//        }
//        
//        formula += num
//        calculationFormula.text = formula
//    }
    
    @IBAction func tapDeleteBtn(_ sender: Any) {
        
        formula.removeLast()
        if formula == "" {
            formula = "0"
        }
        calculationFormula.text = formula
    }
    
}
