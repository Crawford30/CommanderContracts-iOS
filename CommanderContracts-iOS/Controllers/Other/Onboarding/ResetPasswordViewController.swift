//
//  ResetPasswordViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/25/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var forgotPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        setUpView()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func forgotPasswordBtnAction(_ sender: Any) {
        Utilities.vibrate()
    }
    
    
    
    
    
    func setUpView(){
        forgotPasswordBtn.layer.cornerRadius = Constants.cornerRadius
        
        forgotPasswordTextField.returnKeyType = .continue
        forgotPasswordTextField.leftViewMode = .always
        forgotPasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        forgotPasswordTextField.autocapitalizationType = .none
        forgotPasswordTextField.autocorrectionType = .no
        forgotPasswordTextField.layer.masksToBounds = true
        forgotPasswordTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //.secondarySystemBackground
        forgotPasswordTextField.layer.cornerRadius = Constants.cornerRadius
        forgotPasswordTextField.layer.borderWidth = 2.0
        forgotPasswordTextField.layer.borderColor = UIColor.white.cgColor
        
        
    }

    @IBAction func backBtnTapped(_ sender: Any) {
        Utilities.vibrate()
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
