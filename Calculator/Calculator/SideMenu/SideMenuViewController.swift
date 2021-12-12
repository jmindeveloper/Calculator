//
//  SideMenuViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/12.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let calculatorType: [String] = ["일반계산기", "단위변환기", "환율계산기", "단가계산기"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculatorType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as? SideMenuCell else { return UITableViewCell() }
        
        let title = calculatorType[indexPath.row]
        cell.calculatorLabel.setTitle(title, for: .normal)
        
        return cell
    }
}

class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var calculatorLabel: UIButton!
    
    @IBAction func typeOfCalculator(_ sender: UIButton) {
    }
    
}
