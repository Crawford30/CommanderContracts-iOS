//
//  GeneratePDFViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/30/21.
//

import UIKit

class GeneratePDFViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        
        
        Utilities.vibrate()
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
