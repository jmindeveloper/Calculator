//
//  ViewController.swift
//  Calculator
//
//  Created by J_Min on 2021/12/12.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    var naviTitle = "asfd"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initTitle()
    }
    
    func initTitle() {
        let nTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
//        nTitle.numberOfLines = 2
        nTitle.textAlignment = .center
//        nTitle.textColor = .lightGray
        nTitle.font = UIFont.systemFont(ofSize: 15)
        nTitle.text = naviTitle
        self.navigationItem.titleView = nTitle
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .lightGray
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
    }
}

