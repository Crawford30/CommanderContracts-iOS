//
//  GeneratePDFViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/30/21.
//

import UIKit

class GeneratePDFViewController: UIViewController {
    
    @IBOutlet weak var clientImageView: UIImageView!
    var contractorCompanyName: String  = ""
    var contractorCompanyAddress: String  = ""
    var contractorCompanyEmail: String  = ""
    var contractorSignUrl: String  = ""
    
    
    var clientName: String  = ""
    var clientAdress: String  = ""
    var contractDate: String  = ""
    var clientSignUri: String  = ""
    
    var contractDesc: String  = ""
    var contractPrice: String  = ""
    
    
    
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    let singletonInstance = ContractSingleton.shared
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSentData()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        
        Utilities.vibrate()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    func getSentData() {
        let singletonInstance = ContractSingleton.shared
        
        contractorCompanyName = singletonInstance.getContractorCompanyName()
        contractorCompanyAddress = singletonInstance.getContractorAddress()
        contractorCompanyEmail = singletonInstance.getContractorEmail()
        contractorSignUrl = singletonInstance.getContractorSignUrl()
        clientName = singletonInstance.getClientName()
        clientAdress = singletonInstance.getClientAddress()
        contractDate = singletonInstance.getContractDate()
        clientSignUri = singletonInstance.getClientSignUri()
        contractDesc = singletonInstance.getContractDescription()
        contractPrice = String(singletonInstance.getContractAmount())
        
        
        navBar.topItem?.title = clientName
        
        clientImageView.loadImageUsingCacheFromUrlString(urlString: clientSignUri)
        
        
        

        
        
        
        
    }
    
    
    
    
    
    
    
    
    
}



