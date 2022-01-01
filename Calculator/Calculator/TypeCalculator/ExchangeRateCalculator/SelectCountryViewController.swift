//
//  SelectCountryViewController.swift
//  Calculator
//
//  Created by J_Min on 2022/01/01.
//

import UIKit

class SelectCountryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var countryList = [String]()
    var selectCountry = ""
    var sendCountry: ((String) -> (Void))?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListCell", for: indexPath) as? CountryListCell else { return UITableViewCell() }
        
        cell.countryLabel.text = countryList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCountry = countryList[indexPath.row]
        print(selectCountry)
    }
    
    @IBAction func okBtn(_ sender: Any) {
        sendCountry?(selectCountry)
        self.dismiss(animated: true, completion: nil)
    }
}

class CountryListCell: UITableViewCell {
    @IBOutlet weak var countryLabel: UILabel!
}
