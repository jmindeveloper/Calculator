//
//  ExchangeRateViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/12.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        getRate("USD", date: "20211230")
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "환율계산기"
        
        let icon = UIImage(systemName: "line.horizontal.3")
        let item = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(showSideMenu))
        self.navigationItem.leftBarButtonItem = item
    }
    
    func getRate(_ currencyName: String, date: String) {
        guard let url = URL(string: "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=1pXO1xLeYHOZdZEwpdVIvcZ39rfv6Bii&searchdate=\(date)&data=AP01&cur_unit=\(currencyName)") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            let rateInformation = try? decoder.decode(Rate.self, from: data)
            print("환율 --> \(rateInformation)")
        }.resume()
    }
    
    @objc func showSideMenu() {
        guard let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") else { return }
        self.present(sideMenuVC, animated: true, completion: nil)
    }
}
