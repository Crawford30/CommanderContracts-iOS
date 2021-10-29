//
//  ExistingContractsViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/29/21.
//

import UIKit

class ExistingContractsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        
        Utilities.vibrate()
        self.dismiss(animated: true, completion: nil)
    }
    

}
