//
//  ResetPasswordViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/25/21.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var forgotPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let bgColor = UIColor.rgb(red: 157.0, green: 169.0, blue: 170.0, alpha: 1.0)
        self.view.backgroundColor = bgColor
        
        setUpView()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func forgotPasswordBtnAction(_ sender: Any) {
        Utilities.vibrate()
        
        
        if (forgotPasswordTextField.text?.isEmpty)! {
            
            self.displayMessage(title: "Error", userMessage: "E-mail field is required")
            
        }
        
        
        callFIRPasswordReset()
        
   
    }
    
    
    //============function to display alert messages==================
    func displayMessage(title: String, userMessage: String ) -> Void {
        
        DispatchQueue.main.async {
            
            Utilities.vibrateOnNotificationSuccess()
            
            let alertController = UIAlertController (title: title, message: userMessage, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    // MARK: Firebase Forgotpassword
        func callFIRPasswordReset(){
            //show loader

            Auth.auth().sendPasswordReset(withEmail: self.forgotPasswordTextField.text!) { (error) in
                DispatchQueue.main.async {
                    //hide loader

                    self.forgotPasswordTextField.text = ""

                    if let error = error {
                        //show alert here
                        
                        self.displayMessage(title: "Error", userMessage: "An error has occured. Please try again later")
                        print(error.localizedDescription)
                    }
                    else {
                        //show alert here
                        
                        self.displayMessage(title: "Success", userMessage: "We send you an email with instructions on how to reset your password.")
                        
                    }
                }
            }
        }
    
    
    
    
    func setUpView(){
        forgotPasswordBtn.layer.cornerRadius = Constants.cornerRadius
        
        forgotPasswordBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        forgotPasswordBtn.titleLabel?.numberOfLines = 1
        forgotPasswordBtn.titleLabel?.minimumScaleFactor = 0.1
        forgotPasswordBtn.clipsToBounds = true
        
        
        forgotPasswordTextField.attributedPlaceholder = NSAttributedString(string: "E-mail Address",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
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
