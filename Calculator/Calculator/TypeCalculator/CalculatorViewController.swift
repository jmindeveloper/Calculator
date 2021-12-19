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
        
        // MARK: calculator Delegate
        calculatorKeyboard.numPadDelegate = self
        calculatorKeyboard.dotKeyDelegate = self
        calculatorKeyboard.operatorKeyDelegate = self
        calculatorKeyboard.parenthesisDelegate = self
        calculatorKeyboard.equalDelegate = self
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
        
        // 앞에 ) 있으면 곱해주기
        if String(frontCusorString.last!) == ")" {
            self.calculationFormula.text = frontCusorString + "×" + str + backCusorString
            moveCusor(offset + 3)
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
    
    func dotData(_ dot: String) {
        print("dotData 실행")
        
        let isOperator = { (s: String) -> Bool in
            if s == "×" || s == "−" || s == "+" || s == "÷" || s == "^" {
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
            
            /*
             frontCusorString및 backCusorString에서 한글자씩 비교
             dot이 이미 있으면 dot추가 안하고 return
             dot이 없이 연산자나 각 문자열의 끝을 만나면 dot 추가
             */
        
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
            if s == "×" || s == "−" || s == "+" || s == "÷" || s == "^" {
                return true
            } else {
                 return false
            }
        }
        
        if self.calculationFormula.text == "0" && !(operatorKey == "-") {
            self.calculationFormula.text = "\(operatorKey)"
            moveCusor(1)
            return
        }
        
        var frontCusorString = self.positionOfCusor().0
        let backCusorString = self.positionOfCusor().1
        let offset = self.positionOfCusor().2
        let frontCusorStringLast = String(frontCusorString.last ?? Character("a"))
        let backCusorStringFirst = String(backCusorString.first ?? Character("a"))
        
        if isOperator(frontCusorStringLast) || isOperator(backCusorStringFirst) {
            if operatorKey == "−" {
                self.calculationFormula.text = frontCusorString + "(−" + backCusorString
                moveCusor(offset + 3)
            }
            
            return
        } else {
            if frontCusorString == "" {
                if operatorKey == "-" {
                    self.calculationFormula.text = "-" + backCusorString
                    return
                } else {
                    return
                }
            } else {
                frontCusorString += operatorKey
                self.calculationFormula.text = frontCusorString + backCusorString
                moveCusor(offset + 2)
            }
        }
    }
}

// MARK: 괄호키 눌렀을때
extension CalculatorViewController: ParenthesisDelegate {
    
    func parenthesis() {
        let frontCusorString = positionOfCusor().0
        var testFrontCusorString = positionOfCusor().0
        let backCusorString = positionOfCusor().1
        let offset = positionOfCusor().2
        
        var leftParenthesisCount = 0
        var rightParenthesisCount = 0
        
        // frontCusorString에 ( 와 ) 이 각각 몇개있는지 센다
        for _ in 0..<testFrontCusorString.count {
            if let stringElement = testFrontCusorString.popLast() {
                if String(stringElement) == "(" {
                    leftParenthesisCount += 1
                } else if String(stringElement) == ")" {
                    rightParenthesisCount += 1
                }
            }
        }
        
        let isOperator = { (s: String) -> Bool in
            if s == "×" || s == "−" || s == "+" || s == "÷" || s == "^" {
                return true
            } else {
                 return false
            }
        }
        
        // calculationFormula에 0만 있으면 (
        if self.calculationFormula.text == "0" {
            self.calculationFormula.text = "("
            moveCusor(1)
            return
        }
        
        // 커서가 맨 앞이면 (
        if offset == -1 {
            self.calculationFormula.text = "(" + self.calculationFormula.text
            moveCusor(offset + 2)
            return
        }
        
        // 연산자 앞이면 (
        if isOperator(String(frontCusorString.last!)) {
            self.calculationFormula.text = "\(frontCusorString)(\(backCusorString)"
            moveCusor(offset + 2)
            return
        }
        
        // ( 가 없거나 ( 및 ) 의 개수가 같을때
        if leftParenthesisCount == 0 || leftParenthesisCount == rightParenthesisCount {
            // frontCusurString의 맨 뒷글자가 숫자라면 x(
            if !isOperator(String(frontCusorString.last!)) {
                self.calculationFormula.text = "\(frontCusorString)×(\(backCusorString)"
                moveCusor(offset + 3)
                return
            }
            // 아니라면 (
            self.calculationFormula.text = "\(frontCusorString)(\(backCusorString)"
            moveCusor(offset + 2)
            return
        }
        
        // ( 가 ) 보다 많을때
        if leftParenthesisCount > rightParenthesisCount {
            // frontCusorString의 뒷글자가 숫자라면 )
            if !isOperator(String(frontCusorString.last!)) {
                self.calculationFormula.text = "\(frontCusorString))\(backCusorString)"
                moveCusor(offset + 2)
                return
            }
        }
        
        // frontCusorString의 뒷글자가 ( 라면 (
        if String(frontCusorString.last!) == "(" {
            self.calculationFormula.text = "\(frontCusorString)(\(backCusorString)"
            moveCusor(offset + 2)
            return
        }
        
    }
}

// MARK: equal Key
extension CalculatorViewController: EqualDelegate {
    
    func equalKey() {
        print("equal")
        
        let formula = self.calculationFormula.text!
        let formulaArray = changeArray(formula)
        
        print("formulaArray --> \(formulaArray)")
        
        let postFix = changePostfix(formulaArray)
        print("postFix --> \(postFix)")
        let result = calculation(postFix)
        print(result)
    }
    
    // string을 숫자와 연산자로 쪼개기
    func changeArray(_ str: String) -> [String] {
        
        var formulaArray = [String]()
        var number = ""
        
        for i in str {
            // 글자 하나하나 때와서 그 글자가 숫자이거나 . 이면
            if i.isNumber || String(i) == "." {
                // number에 추가
                number.append(contentsOf: String(i))
            } else {
                // array에 number랑 연산자 append
                formulaArray.append(number)
                formulaArray.append(String(i))
                number = ""
            }
        }
        formulaArray.append(number)
        // 혹시 빈 문자열 잇으면 제거
        formulaArray.removeAll { $0 == "" }

        return formulaArray
    }
    
    // MARK: 후위표기법
    func changePostfix(_ formula: [String]) -> [String] {
        print(formula)

        var numStack = [String]()
        var operatorStack = [String]()
        
        for element in formula {

            if element == "(" {
                operatorStack.append("(")
            } else if element == ")" {
                while let opr = operatorStack.popLast() {
                    guard opr != "(" else { break }
                    numStack.append(opr)
                }
            } else if element == "×" || element == "÷" || element == "^" {
                guard !operatorStack.isEmpty else { operatorStack.append(element); continue }
                
                while let opr = operatorStack.last, (opr == "×" || opr == "÷" || opr == "^") {
                    numStack.append(operatorStack.popLast()!)
                }
                operatorStack.append(element)
            } else if element == "+" || element == "−" {
                guard !operatorStack.isEmpty else { operatorStack.append(element); continue }
                while let opr = operatorStack.popLast() {
                    guard opr != "("  && opr != "+" && opr != "−" else {
                        if opr == "(" {
                            operatorStack.append(opr)
                            break
                        } else {
                            numStack.append(opr)
                            break
                        }
                    }
                    numStack.append(opr)
                }
                
                operatorStack.append(element)
            } else {
                numStack.append(element)
            }
        }
        
        for _ in 0..<operatorStack.count {
            numStack.append(operatorStack.removeLast())
        }

        return numStack
    }
    
    // MARK: 계산
    func calculation(_ formula: [String]) -> Double {
        
        var resultStack = [Double]()
        print("formula --> \(formula)")
        
        for i in formula {
            print(resultStack)
            guard let element = Double(i) else {
                let a: Double = resultStack.removeLast()
                var b: Double = 0
                
                if let c: Double = resultStack.popLast() {
                    b = c
                } else {
                    b = 0
                }
                
                var result: Double = 1
                
                switch i {
                case "+":
                    result = b + a
                case "−":
                    result = b - a
                case "×":
                    result = b * a
                case "÷":
                    result = b / a
                case "^":
                    result = b
                    for _ in 1..<Int(a) {
                        result *= b
                    }
                default:
                    break
                }
                resultStack.append(result)
                continue
            }
            resultStack.append(element)
        }
        
        return resultStack[0]
    }
    
}


