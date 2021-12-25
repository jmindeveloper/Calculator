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
    
    // cell 개수
    var subjectCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        let gradeCalculatorCustomKeyboard = Bundle.main.loadNibNamed("GradeCalculatorCustomKeyboard", owner: nil, options: nil)
        guard let gradeCalculatorKeyboard = gradeCalculatorCustomKeyboard?.first as? GradeCalculatorCustomKeyboard else { return }
        textField.inputView = gradeCalculatorKeyboard
        textField.becomeFirstResponder()
        
    }
    
    // MARK: set navigation bar item
    func setNavigationBar() {
        self.navigationItem.title = "학점계산기"
        
        let icon = UIImage(systemName: "line.horizontal.3")
        let leftItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(showSideMenu))
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightIcon = UIImage(systemName: "gearshape")
        let rightItem = UIBarButtonItem(image: rightIcon, style: .plain, target: self, action: #selector(optionManu))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    // MARK: sideMenu
    @objc func showSideMenu() {
        guard let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") else { return }
        self.present(sideMenuVC, animated: true, completion: nil)
    }
    
    // MARK: ootionManu
    @objc func optionManu() {
        
    }
    
    // MARK: cell 추가
    @IBAction func addCellBtn(_ sender: Any) {
        subjectCount += 1
        tableView.reloadData()
        let indexPath = IndexPath(row: subjectCount - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        textField.becomeFirstResponder()
    }
    
    // MARK: 초기화
    @IBAction func clearCellBtn(_ sender: Any) {
    }
    
    // MARK: 계산하기
    @IBAction func calculatorBtn(_ sender: Any) {
        
    }
}

extension GradeCalculatorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GradeCalculatorTableViewCell", for: indexPath) as? GradeCalculatorTableViewCell else { return UITableViewCell() }
        
        let gradeCalculatorCustomKeyboard = Bundle.main.loadNibNamed("GradeCalculatorCustomKeyboard", owner: nil, options: nil)
        let gradeCalculatorKeyboard = gradeCalculatorCustomKeyboard?.first as! GradeCalculatorCustomKeyboard
        
        
        
        cell.gradeTextField.inputView = gradeCalculatorKeyboard
        gradeCalculatorKeyboard.gradeClosure = {
            if cell.gradeTextField.isFirstResponder {
                cell.gradeTextField.text = $0
            }
        }
        cell.scoreTextField.inputView = gradeCalculatorKeyboard
        
        
        return cell
    }
}

extension GradeCalculatorViewController {
    
}

class GradeCalculatorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var scoreTextField: UITextField!
    @IBOutlet weak var isMasorBtn: NSLayoutConstraint!
    
    
}
