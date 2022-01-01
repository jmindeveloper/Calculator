//
//  SelectCountryViewController.swift
//  Calculator
//
//  Created by J_Min on 2022/01/01.
//

import UIKit

class SelectCountryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var countryList = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func okBtn(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListCell", for: indexPath) as? CountryListCell else { return UITableViewCell() }
        
        cell.countryLabel.text = countryList[indexPath.row]
        
        return cell
    }
}

class CountryListCell: UITableViewCell {
    
    @IBOutlet weak var countryLabel: UILabel!
}
