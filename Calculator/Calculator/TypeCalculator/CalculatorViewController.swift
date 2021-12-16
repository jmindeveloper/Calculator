//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/12.
//

import UIKit

class CalculatorViewController: UIViewController, CalculatorKeyboardDelegate {
    
    @IBOutlet weak var calculationFormula: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        
        self.customKeyPad()
        self.calculationFormula.becomeFirstResponder()
        
    }
    
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
        
        calculatorKeyboard.delegate = self
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
    
    func outPutData(_ str: String) {
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
        
        self.calculationFormula.text += str
    }
    
    // textView 커서 위치를 기준으로 앞쪽 뒷쪽 쪼개기
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
        
        // textview position 구하기 (offset 위치)
        let position: UITextPosition = self.calculationFormula.position(from: self.calculationFormula.beginningOfDocument, offset: offset)!
        // 구한 Position으로 커서 이동
        self.calculationFormula.selectedTextRange = self.calculationFormula.textRange(from: position, to: position)
        
        
    }
    
}
