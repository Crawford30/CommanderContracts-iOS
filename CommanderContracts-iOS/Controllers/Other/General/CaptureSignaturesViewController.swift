//
//  CaptureSignaturesViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/28/21.
//

import UIKit


enum signatureModes: Int {
    case modeClient
    case modeContractor
    case modeInactive
    
}

class CaptureSignaturesViewController: UIViewController {
    
     var userSignatureMode = signatureModes.modeInactive.rawValue
    
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }

    @IBOutlet weak var captureContractorSignBtn: UIButton!
    @IBOutlet weak var contractorImageView: UIImageView!
    
    @IBOutlet weak var clientImageView: UIImageView!
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var captureClientSignBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        Utilities.vibrate()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func captureContractorSignAction(_ sender: Any) {
        
        userSignatureMode = signatureModes.modeContractor.rawValue
        
         UserDefaults.standard.set(userSignatureMode, forKey: "isClientOrContractor")
        
       // UserDefaults.standard.integer(forKey: <#T##String#>)
        
        Utilities.vibrate()
        
        gotToSignaturePad()
    }
    
    
    @IBAction func captureClientSignAction(_ sender: Any) {
        
        userSignatureMode = signatureModes.modeClient.rawValue
        
        UserDefaults.standard.set(userSignatureMode, forKey: "isClientOrContractor")
        
        Utilities.vibrate()
        
        gotToSignaturePad()
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        
        Utilities.vibrate()
    }
    
    
    private func setUpViews() {
        
        self.view.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        captureContractorSignBtn.layer.cornerRadius = Constants.cornerRadius
        
        
        captureClientSignBtn.layer.cornerRadius = Constants.cornerRadius
        
        
        submitBtn.layer.cornerRadius = Constants.cornerRadius
        
        
        contractorImageView.layer.cornerRadius = Constants.cornerRadius
        clientImageView.layer.cornerRadius = Constants.cornerRadius
        
        let singletonInstance = ClientOrUserSingleton.shared
        
        
        switch userSignatureMode {
        case signatureModes.modeClient.rawValue:
            
            clientImageView.image = singletonInstance.getClientImage()
            
            
            
            break
            
        case signatureModes.modeContractor.rawValue:
            
             contractorImageView.image = singletonInstance.getContractorImage()
            break
        default:
            return
        }
        
        
        
    }
    
    private func gotToSignaturePad() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "SignaturePadID") as? SignaturePadViewController
        homeVC?.modalPresentationStyle = .fullScreen
        self.present(homeVC!, animated: true, completion: nil)
        
        
    }
    

    
    
}
