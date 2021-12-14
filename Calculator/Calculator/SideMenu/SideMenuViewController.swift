//
//  SideMenuViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/12.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let calculatorType: [String] = ["일반계산기", "단위변환기", "환율계산기", "단가계산기", "엔빵계산기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculatorType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as? SideMenuCell else { return UITableViewCell() }
        let title = calculatorType[indexPath.row]
        
        cell.TypeOfCalculator.text = title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("일반계산기")
            tapSideMenu("CalculatorViewController", "calculatorVC")
        case 1:
            print("단위변환기")
            tapSideMenu("UnitConversionViewController", "unitConvertVC")

        case 2:
            tapSideMenu("ExchangeRateViewController", "exchangeRateVC")
        case 3:
            print("단가계산기")
            tapSideMenu("UnitPriceViewController", "unitPriceVC")
        case 4:
            print("엔빵계산기")
            
        default:
            break
        }
    }
    
    func tapSideMenu(_ view: String, _ VC: String) {
        // presentingViewController: the view Controller that presented this controller
        // 사이드메뉴 컨트롤러에서 메인컨트롤러(네비게이션)을 찾아서 pushViewController 해줌
        guard let VC = self.storyboard?.instantiateViewController(withIdentifier: view) else { return }
        let target = self.presentingViewController as! UINavigationController
        target.pushViewController(VC, animated: false)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func settingBtn(_ sender: Any) {
        
    }
    
}

class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var TypeOfCalculator: UILabel!
}
