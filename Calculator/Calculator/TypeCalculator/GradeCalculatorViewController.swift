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
    var gradeArr: [Grade] = [
        Grade(grade: "", score: "", isMasor: false),
        Grade(grade: "", score: "", isMasor: false),
        Grade(grade: "", score: "", isMasor: false),
        Grade(grade: "", score: "", isMasor: false),
        Grade(grade: "", score: "", isMasor: false)
    ]
    
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
        gradeArr.append(Grade(grade: "", score: "", isMasor: false))
    }
    
    // MARK: 초기화
    @IBAction func clearCellBtn(_ sender: Any) {
        
        subjectCount = 5
        gradeArr = [
            Grade(grade: "", score: "", isMasor: false),
            Grade(grade: "", score: "", isMasor: false),
            Grade(grade: "", score: "", isMasor: false),
            Grade(grade: "", score: "", isMasor: false),
            Grade(grade: "", score: "", isMasor: false)
        ]
        tableView.reloadData()
        
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
        
        cell.gradeTextField.text = gradeArr[indexPath.row].grade
        cell.scoreTextField.text = gradeArr[indexPath.row].score
        
        cell.gradeTextField.inputView = gradeCalculatorKeyboard
        gradeCalculatorKeyboard.gradeClosure = { [weak self] in
            guard let self = self else { return }
            if cell.gradeTextField.isFirstResponder {
                cell.gradeTextField.text = $0
                self.gradeArr[indexPath.row].grade = $0
            }
        }
        
        cell.scoreTextField.inputView = gradeCalculatorKeyboard
        gradeCalculatorKeyboard.scoreClosure = { [weak self] in
            guard let self = self else { return }
            if cell.scoreTextField.isFirstResponder {
                cell.scoreTextField.text = $0
                self.gradeArr[indexPath.row].score = $0
            }
        }
        
        let image = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate)
        cell.isMasorBtn.setImage(image, for: .normal)
        
        cell.isMasorBtn.addTarget(self, action: #selector(tappedIsMasorBtn(_:)), for: .touchUpInside)
        
        if gradeArr[indexPath.row].isMasor! {
            cell.isMasorBtn.tintColor = .systemBlue
        } else {
            cell.isMasorBtn.tintColor = .placeholderText
        }
        
        cell.deleteBtn.addTarget(self, action: #selector(tappedDeleteBtn(_:)), for: .touchUpInside)
        return cell
    }
    
    // MARK: isMasorBtn tapped
    @objc func tappedIsMasorBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        
        gradeArr[indexPath.row].isMasor = !gradeArr[indexPath.row].isMasor!
        print(gradeArr[indexPath.row].isMasor!)
        tableView.reloadData()
        textField.becomeFirstResponder()
    }
    
    // MARK: deleteBtn tapped
    @objc func tappedDeleteBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        
        gradeArr.remove(at: indexPath.row)
        subjectCount -= 1
        tableView.deleteRows(at: [indexPath], with: .automatic)
//        tableView.reloadData()
        textField.becomeFirstResponder()
    }
}

class GradeCalculatorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var scoreTextField: UITextField!
    @IBOutlet weak var isMasorBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
}
