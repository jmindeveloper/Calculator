//
//  UnitConversionViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/12.
//

import UIKit

class UnitConversionViewController: UIViewController {
    
    var unitConvert = [UnitConvertElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        
        getUnit()
        print("unitConvert --> \(unitConvert)")
    }
    
    // MARK: json 파싱
    func getUnit() {
        guard let path = Bundle.main.path(forResource: "UnitConverse", ofType: "json") else { return }
        print("path --> \(path)")
        guard let jsonString = try? String(contentsOfFile: path) else { return }
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        if let data = data {
            if let unit = try? decoder.decode([UnitConvertElement].self, from: data) {
                print("unit --> \(unit)")
                unitConvert = unit
            }
            
        }
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "단위변환기"
        
        let icon = UIImage(systemName: "line.horizontal.3")
        let item = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(showSideMenu))
        self.navigationItem.leftBarButtonItem = item
    }
    
    @objc func showSideMenu() {
        guard let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") else { return }
        self.present(sideMenuVC, animated: true, completion: nil)
    }
}
