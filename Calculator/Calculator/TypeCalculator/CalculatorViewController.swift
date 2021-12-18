//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/12.
//

import UIKit
import SideMenu

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var calculationFormula: UITextView!
    var formula = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        
        self.customKeyPad()
        self.calculationFormula.becomeFirstResponder()
        
        moveCusor(1)
    }
    
    // MARK: customKeyPad
    func customKeyPad() {
        // nib 불러오기
        let calculatorCustomKeyboard = Bundle.main.loadNibNamed("CalculatorCustomKeyboard", owner: nil, options: nil)
        // CalculatorCustomKeyboard로 다운캐스팅
        guard let calculatorKeyboard = calculatorCustomKeyboard?.first as? CalculatorCustomKeyboard else { return }
        // inputView = calculatorKeyboard
        calculationFormula.inputView = calculatorKeyboard
        // calculationFormula(UITextView) firstResponder처리해줘 뷰 실행시 키보드 같이 뜸
        // firstResponder 해제 구현을 안해 키보드가 안내려옴
        // 키보드를 하나의 뷰처럼 보이게
        calculationFormula.becomeFirstResponder()
        
        calculatorKeyboard.numPadDelegate = self
        calculatorKeyboard.dotKeyDelegate = self
        calculatorKeyboard.operatorKeyDelegate = self
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
    
    // MARK: textView 커서 위치를 기준으로 앞쪽 뒷쪽 쪼개기
    func positionOfCusor() -> (String, String, Int) {
        let formulaString = self.calculationFormula.text!
        // 커서위치 구하기
        let textRange = self.calculationFormula.selectedTextRange!
        // 구한 커서위치 가 몇번째 문자인지 구하기
        let offset = self.calculationFormula.offset(from: self.calculationFormula.beginningOfDocument, to: textRange.start) - 1
        print("offset --> \(offset)")
        
        // 커서가 문자 맨 앞에 위치할 경우
        if offset == -1 {
            return ("no result", "no result", offset)
        }
    
        // 커서 앞 문자
        let frontCusor = formulaString.index(formulaString.startIndex, offsetBy: offset)
        let frontCusorString = String(formulaString[...frontCusor])
        // 커서 뒷 문자
        let backCusor = formulaString.index(formulaString.startIndex, offsetBy: offset + 1)
        let backCusorString = String(formulaString[backCusor...])
        print("frontCusorString --> \(frontCusorString)")
        print("backCusorString --> \(backCusorString)")
        return (frontCusorString, backCusorString, offset)
    }
    
    // MARK: 커서이동
    func moveCusor(_ offset: Int) {
        // textview position 구하기 (offset 위치)
        let position: UITextPosition = self.calculationFormula.position(from: self.calculationFormula.beginningOfDocument, offset: offset)!
        // 구한 Position으로 커서 이동
        self.calculationFormula.selectedTextRange = self.calculationFormula.textRange(from: position, to: position)
    }
    
    // MARK: 지우기버튼
    @IBAction func tapDeleteBtn(_ sender: Any) {
        
        var frontCusorString = positionOfCusor().0
        let backCusorString = positionOfCusor().1
        let offset = positionOfCusor().2
        
        // 커서가 문자 맨 앞에 위치할때 return
        if offset == -1 {
            return
        }
        
        // 커서 앞이 비어있지 않을때 커서 앞 문자열의 맨 뒷자리 지우기
        if frontCusorString != "" {
            frontCusorString.removeLast()
        }
        
        // 지운 커서 앞 문자열과 커서 뒷 문자열 합쳐서 textview.text에 적용
        self.calculationFormula.text = frontCusorString + backCusorString
        // 왠진 모르겠는데 맨 앞에 " "가 하나 생김
        // 그거 삭제
        self.calculationFormula.text.removeAll() { $0 == " " }
        
        // 만약 textview가 비었을경우 "0"으로 초기화
        if self.calculationFormula.text == "" {
            self.calculationFormula.text = "0"
        }
        moveCusor(offset)
    }
    
}

// MARK: 숫자키 눌렀을때
extension CalculatorViewController: NumPadDelegate {
    
    func numData(_ str: String) {
        inputNum(str)
    }
    
    func inputNum(_ str: String) {
        // 초기상태 calculationFormula == "0" 일때
        if self.calculationFormula.text == "0" {
            // 버튼 클릭시 calculationFormula "" 로 초기화
            self.calculationFormula.text = ""
            // "00"이 들어왔을때
            if str == "00" {
                self.calculationFormula.text = "0"
                return
            }
        }
        
        var frontCusorString = positionOfCusor().0
        let backCusorString = positionOfCusor().1
        let offset = positionOfCusor().2
        
        if offset == -1 {
            
            // 맨 앞에 00이나 0이 올 수 없음
            if str == "00" || str == "0" {
                return
            }
            
            self.calculationFormula.text = str + self.calculationFormula.text
            
            moveCusor(1)
            return
        }
        
        frontCusorString += str
        
        self.calculationFormula.text = frontCusorString + backCusorString
        
        if backCusorString != "" {
            // 중간에 두글자 입력일경우 커서가 한칸 더 밀려야함
            let offSet: Int = str == "00" ? offset + 3: offset + 2
            
            moveCusor(offSet)
        }
    }
}

// MARK: dot키 눌렀을때
extension CalculatorViewController: DotKeyDelegate {
    
    /*
     while문으로 각각 커서 위치에서 앞뒤로 움직이면서 연산자를 만나기 전에 dot이 있으면 return
     없으면 dot 추가
     */
    
    func dotData(_ dot: String) {
        print("dotData 실행")
        
        let isOperator = { (s: String) -> Bool in
            if s == "×" || s == "−" || s == "+" || s == "÷" {
                return true
            } else {
                 return false
            }
        }
        
        let isDot = { (s: String) -> Bool in
            if s == "." {
                return true
            } else {
                return false
            }
        }
        
        if self.calculationFormula.text == "0" {
            self.calculationFormula.text = "0."
            return
        }
        
        let frontCusorString = self.positionOfCusor().0
        let backCusorString = self.positionOfCusor().1
        let offset = self.positionOfCusor().2
        
        var okDot = false
        
        var frontString = ""
        var backString = ""
        var frontOperator = false
        var backOperator = false
        var count = 0
        var frontLast = false
        var backLast = false
        
        while !(frontOperator && backOperator) {
            
            print(count)
        
            if count < frontCusorString.count && frontOperator == false {
                frontString = String(frontCusorString[frontCusorString.index(frontCusorString.endIndex, offsetBy: -1 - count)])
                print("frontCharacter --> \(frontString)")
            }
            
            if count < backCusorString.count && backOperator == false  {
                backLast = true
                backString = String(backCusorString[backCusorString.index(backCusorString.startIndex, offsetBy: count)])
                print("backCharacter --> \(backString)")
            }
            
            if count > frontCusorString.count && count > backCusorString.count {
                frontLast = true
                frontOperator = true
                backOperator = true
                break
            }
            
            if isDot(frontString) || isDot(backString) {
                okDot = true
            }
            
            if isOperator(frontString) {
                frontOperator = true
                print(frontOperator)
            }
            
            if isOperator(backString) {
                backOperator = true
                print(backOperator)
            }
            
            count += 1
        }
        print("Asd")
        if okDot {
            return
        }
        
        if frontOperator || backOperator || (frontOperator && backLast) || (backOperator && frontLast) {
            self.calculationFormula.text = "\(frontCusorString).\(backCusorString)"
            
            moveCusor(offset + 2)
        }
        
        
    }
}

// MARK: 연산자 키 눌렀을때
extension CalculatorViewController: OperatorKeyDelegate {
    
    func operatorData(_ operatorKey: String) {
        
        let isOperator = { (s: String) -> Bool in
            if s == "×" || s == "−" || s == "+" || s == "÷" {
                return true
            } else {
                 return false
            }
        }
        
        if self.calculationFormula.text == "0" && operatorKey == "−" {
            self.calculationFormula.text = "−"
            return
        }
        
        var frontCusorString = self.positionOfCusor().0
        let backCusorString = self.positionOfCusor().1
        let offset = self.positionOfCusor().2
        let frontCusorStringLast = String(frontCusorString.last ?? Character("a"))
        let backCusorStringFirst = String(backCusorString.first ?? Character("a"))
        
        if isOperator(frontCusorStringLast) || isOperator(backCusorStringFirst) {
            return
        } else {
            frontCusorString += operatorKey
            self.calculationFormula.text = frontCusorString + backCusorString
            moveCusor(offset + 2)
        }
    }
}
