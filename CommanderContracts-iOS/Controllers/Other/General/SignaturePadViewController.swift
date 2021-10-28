//
//  SignaturePadViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/28/21.
//

import UIKit


enum possibleSignatureModes: Int {
    case modeClient
    case modeContractor
    case modeInactive
    
}



class SignaturePadViewController: UIViewController {
    
    var valueForInfo:Int = 0
    
    var myCurrentMode = possibleSignatureModes.modeInactive.rawValue
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    @IBOutlet weak var signatureView: Canvas! {
        didSet {
            
            signatureView.layer.cornerRadius = Constants.cornerRadius
            signatureView.isDrawingHandler = { [weak self] isDrawing in
                self?.clearBtn.isEnabled = !isDrawing
            }
        }
    }
    
  
    
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        
        valueForInfo = UserDefaults.standard.integer(forKey: "isClientOrContractor")

      
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        Utilities.vibrate()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        
        Utilities.vibrate()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func clearBtnAction(_ sender: Any) {
        
        Utilities.vibrate()
        
        signatureView.clear()
    }
    
    
    
    @IBAction func okBtnAction(_ sender: Any) {
        
        let singletonInstance = ClientOrUserSingleton.shared
        
        let signatureSaved = signatureView.image
        
//        secondVC.signature = signatureSaved ?? UIImage()
        
        Utilities.vibrate()
        
        switch valueForInfo  {
        case possibleSignatureModes.modeClient.rawValue:
            
            singletonInstance.setClientImage(theImage: signatureSaved ?? UIImage() )
            
            self.dismiss(animated: true, completion: nil)
            
            
            break
            
        case possibleSignatureModes.modeContractor.rawValue:
            
            singletonInstance.setContractorImage(theImage: signatureSaved ?? UIImage())
            
            self.dismiss(animated: true, completion: nil)
            break
        default:
            return
        }
        
        
      
    }
    
    
    
    private func setUpViews() {
        
        
        cancelBtn.layer.cornerRadius = Constants.cornerRadius
        clearBtn.layer.cornerRadius = Constants.cornerRadius
        okBtn.layer.cornerRadius = Constants.cornerRadius
        
    }
   
}
