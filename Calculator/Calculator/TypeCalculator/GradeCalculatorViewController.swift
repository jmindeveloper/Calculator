//
//  GradeCalculatorViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/22.
//

import UIKit

class GradeCalculatorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var subjectCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        let gradeCalculatorCustomKeyboard = Bundle.main.loadNibNamed("GradeCalculatorCustomKeyboard", owner: nil, options: nil)
        // CalculatorCustomKeyboard로 다운캐스팅
        guard let gradeCalculatorKeyboard = gradeCalculatorCustomKeyboard?.first as? GradeCalculatorCustomKeyboard else { return }
        // inputView = calculatorKeyboard
        textField.inputView = gradeCalculatorKeyboard
        // calculationFormula(UITextView) firstResponder처리해줘 뷰 실행시 키보드 같이 뜸
        // firstResponder 해제 구현을 안해 키보드가 안내려옴
        // 키보드를 하나의 뷰처럼 보이게
//        calculationFormula.becomeFirstResponder()
        textField.becomeFirstResponder()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "일반계산기"
        
        let icon = UIImage(systemName: "line.horizontal.3")
        let leftItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(showSideMenu))
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightIcon = UIImage(systemName: "gearshape")
        let rightItem = UIBarButtonItem(image: rightIcon, style: .plain, target: self, action: #selector(optionManu))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func showSideMenu() {
        guard let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") else { return }
        self.present(sideMenuVC, animated: true, completion: nil)
    }
    
    @objc func optionManu() {
        
    }
    
    
    
}

extension GradeCalculatorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GradeCalculatorTableViewCell", for: indexPath) as? GradeCalculatorTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}

class GradeCalculatorTableViewCell: UITableViewCell {
    
}
