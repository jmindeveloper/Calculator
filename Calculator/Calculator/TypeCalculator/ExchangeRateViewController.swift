//
//  ExchangeRateViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/12.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    
    var rateInformation: [RateInformation] = []
    
    @IBOutlet weak var amountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        
        // MARK: 환율정보 알림
        getRate("20211231")
        let alert = UIAlertController(title: nil, message: "해당 환율 정보는 한국수출입은행에서 제공합니다.\n비영업일 혹은 영업당일 11시 이전에 조회하실경우\n이전영업일의 환율정보로 조회됩니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true) { self.getRate("20211231"); print(self.rateInformation) }
        
        let changeRateCalculatorCustomKeyboard = Bundle.main.loadNibNamed("ChangeRateCustomKeyboard", owner: nil, options: nil)
        guard let changeRateCalculatorKeyboard = changeRateCalculatorCustomKeyboard?.first as? ChangeRateCustomKeyboard else { return }
        
        amountTextField.inputView = changeRateCalculatorKeyboard
        amountTextField.becomeFirstResponder()
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
    
    @objc func showSideMenu() {
        guard let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") else { return }
        self.present(sideMenuVC, animated: true, completion: nil)
    }
    
    func filterCountry(_ rate: Rate) -> [String] {
        let countryList = rate.map { $0.currencyName }
        return countryList
    }
    
    @IBAction func beforeCountry(_ sender: Any) {
        let countryList = filterCountry(rateInformation)
        guard let SelectCountryVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectCountryViewController") as? SelectCountryViewController else { return }
        SelectCountryVC.countryList = countryList
        self.present(SelectCountryVC, animated: true, completion: nil)
    }
    
    @IBAction func afterCountry(_ sender: Any) {
        let countryList = filterCountry(rateInformation)
        guard let SelectCountryVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectCountryViewController") as? SelectCountryViewController else { return }
        SelectCountryVC.countryList = countryList
        self.present(SelectCountryVC, animated: true, completion: nil)
    }
    
}
