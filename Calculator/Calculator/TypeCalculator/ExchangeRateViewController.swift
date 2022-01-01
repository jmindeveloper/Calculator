//
//  ExchangeRateViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/12.
//

import UIKit
import SideMenu

class ExchangeRateViewController: UIViewController {
    
    var rateInformation: [RateInformation] = []
    var beforeCountry = ""
    var afterCountry = ""
    
    @IBOutlet weak var beforeCountryBtnTxt: CustomUIButton!
    @IBOutlet weak var afterCountryBtnTxt: CustomUIButton!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dealBaseRateLabel: UILabel!
    @IBOutlet weak var sendMoneyLabel: UILabel!
    @IBOutlet weak var recieveMoneyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        
        // MARK: 환율정보 알림
        getRate("20211231")
        let alert = UIAlertController(title: nil, message: "해당 환율 정보는 한국수출입은행에서 제공합니다.\n비영업일 혹은 영업당일 11시 이전에 조회하실경우\n이전영업일의 환율정보로 조회됩니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true) {
            self.getRate("20211231")
            print(self.rateInformation)
        }
        
        let changeRateCalculatorCustomKeyboard = Bundle.main.loadNibNamed("ChangeRateCustomKeyboard", owner: nil, options: nil)
        guard let changeRateCalculatorKeyboard = changeRateCalculatorCustomKeyboard?.first as? ChangeRateCustomKeyboard else { return }
        
        amountTextField.inputView = changeRateCalculatorKeyboard
        amountTextField.becomeFirstResponder()
        changeRateCalculatorKeyboard.changeRateDelegate = self
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "환율계산기"
        
        let icon = UIImage(systemName: "line.horizontal.3")
        let item = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(showSideMenu))
        self.navigationItem.leftBarButtonItem = item
    }
    
    func getRate(_ date: String) {
        guard let url = URL(string: "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=1pXO1xLeYHOZdZEwpdVIvcZ39rfv6Bii&searchdate=\(date)&data=AP01") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            guard let rateInformation = try? decoder.decode(Rate.self, from: data) else { return }
            DispatchQueue.main.async {
                self?.rateInformation = rateInformation
            }
        }.resume()
    }
    
    // MARK: 환율 가져오기
    @objc func showSideMenu() {
        guard let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") else { return }
        self.present(sideMenuVC, animated: true, completion: nil)
    }
    
    // MARK: Rate 국가별 분류
    func filterCountry(_ rate: Rate) -> [String] {
        let countryList = rate.map { $0.currencyName }
        return countryList
    }
    
    // MARK: 국가선택
    @IBAction func beforeCountry(_ sender: Any) {
        let countryList = filterCountry(rateInformation)
        guard let SelectCountryVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectCountryViewController") as? SelectCountryViewController else { return }
        SelectCountryVC.countryList = countryList
        
        SelectCountryVC.sendCountry = { [weak self] in
            guard let self = self else { return }
            self.beforeCountry = $0
            self.beforeCountryBtnTxt.setTitle($0, for: .normal)
        }
        
        self.present(SelectCountryVC, animated: true, completion: nil)
    }
    
    @IBAction func afterCountry(_ sender: Any) {
        let countryList = filterCountry(rateInformation)
        guard let SelectCountryVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectCountryViewController") as? SelectCountryViewController else { return }
        SelectCountryVC.countryList = countryList
        
        SelectCountryVC.sendCountry = { [weak self] in
            guard let self = self else { return }
            self.afterCountry = $0
            self.afterCountryBtnTxt.setTitle($0, for: .normal)
        }
        
        self.present(SelectCountryVC, animated: true, completion: nil)
    }
    
}

extension ExchangeRateViewController: ChangeRateDelegate {
    func numPad(_ num: String) {
        amountTextField.text = amountTextField.text! + num
        let amount = Double(amountTextField.text!)!
        rateCalculator(beforeCountry, afterCountry, amount)
    }
    
    func dotPad(_ dot: String) {
        if !amountTextField.text!.contains(".") && !amountTextField.text!.isEmpty {
            amountTextField.text = amountTextField.text! + dot
        }
    }
    
    func deletePad() {
        if !amountTextField.text!.isEmpty {
            amountTextField.text?.removeLast()
            guard let amount = Double(amountTextField.text!) else { return }
            rateCalculator(beforeCountry, afterCountry, amount)
        }
    }
    
    // MARK: 환율계산
    func rateCalculator(_ beforeCountry: String, _ afterCountry: String, _ amount: Double) {
        guard beforeCountry != "" && afterCountry != "" && amount != 0 else { return }
        
        let beforeCountryRate = rateInformation.filter { $0.currencyName == beforeCountry }
        let afterCountryRate = rateInformation.filter { $0.currencyName == afterCountry }
        print("beforeCountryRate --> \(beforeCountryRate)")
        print("afterCountryRate --> \(afterCountryRate)")
        
        changeRate(beforeCountryRate, afterCountryRate, amount)
    }
    
    func changeRate(_ beforeCountry: Rate, _ afterCountry: Rate, _ amount: Double) {
        // MARK: 매매기준율
        var beforeCountryAmountString = beforeCountry.first!.dealBaseRate
        beforeCountryAmountString.removeAll() { $0 == "," }
        var afterCountryAmountString = afterCountry.first!.dealBaseRate
        afterCountryAmountString.removeAll() { $0 == "," }
        print(afterCountryAmountString)
        let changeKoreaRate = amount * Double(beforeCountryAmountString)!
        print("changeKoreaRate --> \(changeKoreaRate)")
        let changeAfterCountryRate = changeKoreaRate / Double(afterCountryAmountString)!
        print("changeAfterCountryRate --> \(changeAfterCountryRate)")
        dealBaseRateLabel.text = String(changeAfterCountryRate)
        
        // MARK: 송금할때
        if afterCountry.first!.currencyName == "한국 원" {
            sendMoneyLabel.isHidden = false
            recieveMoneyLabel.isHighlighted = false
            var beforeCountrySendMoneyString = beforeCountry.first!.sendMoney
            beforeCountrySendMoneyString.removeAll() { $0 == "," }
            var beforeCountryRecieveMoneyString = beforeCountry.first!.recieveMoney
            beforeCountryRecieveMoneyString.removeAll() { $0 == "," }
            let sendMoney = amount * Double(beforeCountrySendMoneyString)!
            sendMoneyLabel.text = String(sendMoney)
            let recieveMoney = amount * Double(beforeCountryRecieveMoneyString)!
            recieveMoneyLabel.text = String(recieveMoney)
        }
        
        // MARK: 송금받을때
        if beforeCountry.first!.currencyName == "한국 원" {
            sendMoneyLabel.isHidden = false
            recieveMoneyLabel.isHighlighted = false
            var afterCountrySendMoneyString = afterCountry.first!.sendMoney
            afterCountrySendMoneyString.removeAll() { $0 == "," }
            var afterCountryRecieveMoneyString = afterCountry.first!.recieveMoney
            afterCountryRecieveMoneyString.removeAll() { $0 == "," }
            let sendMoney = changeAfterCountryRate * Double(afterCountrySendMoneyString)!
            sendMoneyLabel.text = String(sendMoney)
            let recieveMoney = changeAfterCountryRate * Double(afterCountryRecieveMoneyString)!
            recieveMoneyLabel.text = String(recieveMoney)
        }
        
        if beforeCountry.first!.currencyName != "한국 원" && afterCountry.first!.currencyName != "한국 원" {
            sendMoneyLabel.isHidden = true
            recieveMoneyLabel.isHighlighted = true
        }
        
    }
}
