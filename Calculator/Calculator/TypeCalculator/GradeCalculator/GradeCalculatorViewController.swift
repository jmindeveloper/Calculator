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
    @IBOutlet weak var fullMarkLabel: UILabel!
    
    var fullMark = 4.5
    
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
        fullMarkLabel.text = "4.5점 만점"
        
        let gradeCalculatorCustomKeyboard = Bundle.main.loadNibNamed("GradeCalculatorCustomKeyboard", owner: nil, options: nil)
        guard let gradeCalculatorKeyboard = gradeCalculatorCustomKeyboard?.first as? GradeCalculatorCustomKeyboard else { return }
        textField.inputView = gradeCalculatorKeyboard
        textField.becomeFirstResponder()
        
        print("gradeArr --> \(gradeArr)")
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
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let fourDotfive = UIAlertAction(title: "4.5점 만점", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.fullMarkLabel.text = "4.5점 만점"
            self.fullMark = 4.5
        }
        let fourDotThree = UIAlertAction(title: "4.3점 만점", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.fullMarkLabel.text = "4.3점 만점"
            self.fullMark = 4.3
        }
        let fourDotZero = UIAlertAction(title: "4.0점 만점", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.fullMarkLabel.text = "4.0점 만점"
            self.fullMark = 4.0
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(fourDotfive)
        alert.addAction(fourDotThree)
        alert.addAction(fourDotZero)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: 학점계산
    func gradeCalculator(_ grade: [Grade], _ fullMark: Double) -> (Double, Double) {
        print("gradeArr --> \(gradeArr)")
        
        if grade.contains(where: { i in i.grade == "" || i.score == "" }) || gradeArr.isEmpty {
            let alert = UIAlertController(title: nil, message: "정확한 수치를 입력해주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return (0, 0)
        }
        
        var score: Double = 0
        var totalGrade: Double = 0
        var applyGrade: Double = 0
        for i in grade {
            applyGrade += Double(i.grade)!
            switch i.score {
            case "A+":
                if fullMark == 4.5 {
                    score = 4.5 * Double(i.grade)!
                } else if fullMark == 4.3 {
                    score = 4.3 * Double(i.grade)!
                } else {
                    score = 4.0 * Double(i.grade)!
                }
            case "A":
                if fullMark == 4.5 {
                    score = 4.0 * Double(i.grade)!
                } else if fullMark == 4.3 {
                    score = 4.0 * Double(i.grade)!
                } else {
                    score = 0
                }
            case "A-":
                if fullMark == 4.5 {
                    score = 0
                } else if fullMark == 4.3 {
                    score = 3.7 * Double(i.grade)!
                } else {
                    score = 0
                }
            case "B+":
                if fullMark == 4.5 {
                    score = 3.5 * Double(i.grade)!
                } else if fullMark == 4.3 {
                    score = 3.3 * Double(i.grade)!
                } else {
                    score = 3.0 * Double(i.grade)!
                }
            case "B":
                if fullMark == 4.5 {
                    score = 3.0 * Double(i.grade)!
                } else if fullMark == 4.3 {
                    score = 3.0 * Double(i.grade)!
                } else {
                    score = 0
                }
            case "B-":
                if fullMark == 4.5 {
                    score = 0
                } else if fullMark == 4.3 {
                    score = 2.7 * Double(i.grade)!
                } else {
                    score = 0
                }
            case "C+":
                if fullMark == 4.5 {
                    score = 2.5 * Double(i.grade)!
                } else if fullMark == 4.3 {
                    score = 2.3 * Double(i.grade)!
                } else {
                    score = 2.0 * Double(i.grade)!
                }
            case "C":
                if fullMark == 4.5 {
                    score = 2.0 * Double(i.grade)!
                } else if fullMark == 4.3 {
                    score = 2.0 * Double(i.grade)!
                } else {
                    score = 0
                }
            case "C-":
                if fullMark == 4.5 {
                    score = 0
                } else if fullMark == 4.3 {
                    score = 1.7 * Double(i.grade)!
                } else {
                    score = 0
                }
            case "D+":
                if fullMark == 4.5 {
                    score = 1.5 * Double(i.grade)!
                } else if fullMark == 4.3 {
                    score = 1.3 * Double(i.grade)!
                } else {
                    score = 1.0 * Double(i.grade)!
                }
            case "D":
                if fullMark == 4.5 {
                    score = 1.0 * Double(i.grade)!
                } else if fullMark == 4.3 {
                    score = 1.0 * Double(i.grade)!
                } else {
                    score = 0
                }
            case "D-":
                if fullMark == 4.5 {
                    score = 0
                } else if fullMark == 4.3 {
                    score = 3.7 * Double(i.grade)!
                } else {
                    score = 0
                }
            case "F":
                score = 0
            default:
                score = 0
                break
            }
            totalGrade += score
        }
        print("totalGrade --> \(totalGrade)")
        print("applyGrade --> \(applyGrade)")
        var result = totalGrade / applyGrade
        print("result --> \(result)")
        
        if totalGrade == 0 && totalGrade == 0 {
            result = 0
        }
        
        return (applyGrade, result)
    }
    
    // MARK: cell 추가
    @IBAction func addCellBtn(_ sender: Any) {
        subjectCount += 1
        tableView.reloadData()
        let indexPath = IndexPath(row: subjectCount - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        textField.becomeFirstResponder()
        gradeArr.append(Grade(grade: "", score: "", isMasor: false))
        print("gradeArr --> \(gradeArr)")
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
        print("gradeArr --> \(gradeArr)")
        tableView.reloadData()
        
    }
    
    // MARK: 계산하기
    @IBAction func calculatorBtn(_ sender: Any) {
        
        let calculatedGrade = gradeCalculator(gradeArr, fullMark)
        
        let majorGrade =  gradeArr.filter { $0.isMasor == true }
        
        let majorCalculatedGrade = gradeCalculator(majorGrade, fullMark)
        
        guard let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultGradeViewController") as? ResultGradeViewController else { return }
        resultVC.modalPresentationStyle = .overCurrentContext
        resultVC.modalTransitionStyle = .crossDissolve
        
        resultVC.totalGrade = calculatedGrade.1
        resultVC.applyGrade = calculatedGrade.0
        resultVC.majorTotalGrade = majorCalculatedGrade.1
        resultVC.majorApplyTotalGrad = majorCalculatedGrade.0
        resultVC.fullMark = fullMarkLabel.text!
        
        self.present(resultVC, animated: true, completion: nil)
        
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
                print(self.gradeArr.count)
                print(indexPath.row)
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
        
        if gradeArr[indexPath.row].isMasor {
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
        
        gradeArr[indexPath.row].isMasor = !gradeArr[indexPath.row].isMasor
        print(gradeArr[indexPath.row].isMasor)
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
        tableView.reloadData()
        textField.becomeFirstResponder()
        print("gradeArr --> \(gradeArr)")
    }
}

class GradeCalculatorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var scoreTextField: UITextField!
    @IBOutlet weak var isMasorBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
}
