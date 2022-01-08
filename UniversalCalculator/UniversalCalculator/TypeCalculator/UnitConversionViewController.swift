//
//  UnitConversionViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/12.
//

import UIKit
import DropDown

class UnitConversionViewController: UIViewController {
    
    var unitConvert = [UnitConvertElement]()
    let dropDown = DropDown()
    var typeArray = [UnitType]()
    var figureTextFieldIndex = 0
    var figure: Double = 0
    var defaultType: Double = 0
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var SelectUnitButton: CustomUIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        getUnit()
        setDropDown()
        print("unitConvert --> \(unitConvert)")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // MARK: 초기 --> 길이
        let types = self.unitConvert[0].type.sorted { $0.value < $1.value }
        for i in 0..<types.count {
            let type = UnitConvertToKorean(rawValue: types[i].key)!.description
            self.typeArray.append(UnitType(type: type, figure: types[i].value))
        }
        self.tableView.reloadData()
        
        let unitConvertCalculatorCustomKeyboard = Bundle.main.loadNibNamed("ChangeRateCustomKeyboard", owner: nil, options: nil)
        guard let unitConvertCalculatorKeyboard = unitConvertCalculatorCustomKeyboard?.first as? ChangeRateCustomKeyboard else { return }
        textField.inputView = unitConvertCalculatorKeyboard
        textField.becomeFirstResponder()
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
    
    // MARK: dropDown setting
    func setDropDown() {
        dropDown.dataSource = unitConvert.map { UnitConvertToKorean(rawValue: $0.unitName)!.description }
//        for i in 0..<unitConvert.count {
//            let unitName = unitConvert[i].unitName
//            guard let unitDescription = UnitConvertToKorean(rawValue: unitName)?.description else { return }
//            dropDown.dataSource.append(unitDescription)
//        }
        print("dropDown.dataSource --> \(dropDown.dataSource)")
        dropDown.anchorView = SelectUnitButton
        dropDown.shadowOffset = CGSize(width: 0, height: 0)
        dropDown.shadowRadius = 0
        dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionBackgroundColor = dropDown.backgroundColor!
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
    
    
    
    @IBAction func selectUnitBtn(_ sender: Any) {
        dropDown.show()
        dropDown.selectionAction = { [weak self] in
            guard let self = self else { return }
            self.SelectUnitButton.setTitle($1, for: .normal)
            let types = self.unitConvert[$0].type.sorted { $0.value < $1.value }
            self.typeArray = []
            for i in 0..<types.count {
                let type = UnitConvertToKorean(rawValue: types[i].key)!.description
                self.typeArray.append(UnitType(type: type, figure: types[i].value))
            }
            self.tableView.reloadData()
        }
    }
    
}

extension UnitConversionViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UnitConversionTableViewCell", for: indexPath) as? UnitConversionTableViewCell else { return UITableViewCell() }
        
        let unitConvertCalculatorCustomKeyboard = Bundle.main.loadNibNamed("ChangeRateCustomKeyboard", owner: nil, options: nil)
        guard let unitConvertCalculatorKeyboard = unitConvertCalculatorCustomKeyboard?.first as? ChangeRateCustomKeyboard else { return UITableViewCell() }
        
        cell.typeLabel.text = typeArray[indexPath.row].type
        cell.figureTextField.inputView = unitConvertCalculatorKeyboard
        
        unitConvertCalculatorKeyboard.numPadClosure = { [weak self] in
            guard let self = self else { return }
            if cell.figureTextField.isFirstResponder {
                let beforeText = cell.figureTextField.text ?? ""
                cell.figureTextField.text = beforeText + $0
                let figure = Double(cell.figureTextField.text ?? "") ?? 0
                self.defaultType = self.changeDefaultType(indexPath.row, figure)
            }
            tableView.reloadData()
        }
        cell.figureTextField.text = String(self.defaultType * self.typeArray[indexPath.row].figure)
        return cell
    }
    
    func changeDefaultType(_ index: Int, _ figure: Double) -> Double {
        return figure / typeArray[index].figure
    }
}

class UnitConversionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var figureTextField: UITextField!
    
    
}

