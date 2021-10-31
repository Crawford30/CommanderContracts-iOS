//
//  GeneratePDFViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/30/21.
//

import UIKit

class GeneratePDFViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    @IBOutlet weak var genericView: UIView!
    
    @IBOutlet weak var contractHeaderLabel: UILabel!
    
    @IBOutlet weak var contractorAddressLabel: UILabel!
    
    @IBOutlet weak var clientAddressLabel: UILabel!
    
    @IBOutlet weak var contractDescriptionHeader: UILabel!
    
    @IBOutlet weak var contractDescriptionDetail: UILabel!
    
    
    @IBOutlet weak var contractPriceLabel: UILabel!
    
    @IBOutlet weak var signatureHeaderLabel: UILabel!
    
    @IBOutlet weak var clientSignHeaderLabel: UILabel!
    @IBOutlet weak var contractorSignHeaderLabel: UILabel!
    
    @IBOutlet weak var generatePDFNowBtn: UIButton!
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var contractorImageView: UIImageView!
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
        
        genericView.backgroundColor = .clear
        
        getSentData()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func generatePdfNowAction(_ sender: Any) {
        Utilities.vibrate()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        
        Utilities.vibrate()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    func getSentData() {
        
        generatePDFNowBtn.layer.cornerRadius = Constants.cornerRadius
        
        contractDescriptionDetail.backgroundColor = .clear
        
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
        contractPrice = singletonInstance.getContractAmount()
        
        
        print("Contract Price: \(contractPrice)")
        
        
        navBar.topItem?.title = clientName
        
        
        contractorAddressLabel.text = "\(contractorCompanyName)\n\(contractorCompanyAddress)\n\(contractorCompanyEmail)"
        
        clientAddressLabel.text = "\(clientName)\n\(clientAdress)\n\(contractDate)"
        
        
        contractDescriptionDetail.text = contractDesc
        
        
        contractPriceLabel.text = "PRICE: \("$" + contractPrice)"
        
        fromLabel.text = "FROM: \(clientName)"
        
        
        
        
        clientImageView.loadImageUsingCacheFromUrlString(urlString: clientSignUri)
        clientImageView.contentMode = .scaleAspectFit

        
        
        contractorImageView.loadImageUsingCacheFromUrlString(urlString: contractorSignUrl)
        contractorImageView.contentMode = .scaleAspectFit

        
        
        
        
    }
    
    
    
    
    
    
    
    
    
}



