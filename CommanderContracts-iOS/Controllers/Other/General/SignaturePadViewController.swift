//
//  SignaturePadViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/28/21.
//

import UIKit

class SignaturePadViewController: UIViewController {
    
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
        
        Utilities.vibrate()
    }
    
    
    
    private func setUpViews() {
        
        
        cancelBtn.layer.cornerRadius = Constants.cornerRadius
        clearBtn.layer.cornerRadius = Constants.cornerRadius
        okBtn.layer.cornerRadius = Constants.cornerRadius
        
    }
   
}
