//
//  RegisterViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/18/21.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var companyAddressTextField: UITextField!
    @IBOutlet weak var companyPhoneNumberTextField: UITextField!
    @IBOutlet weak var companyEmailAddressTextField: UITextField!
    @IBOutlet weak var companyPasswordTextField: UITextField!
    @IBOutlet weak var companyConfirmPasswordTextField: UITextField!
    @IBOutlet weak var termsAndPrivacyContainer: UIView!
    
    @IBOutlet weak var registerBtn: UIButton!
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        companyNameTextField.delegate = self
        companyAddressTextField.delegate = self
        companyPhoneNumberTextField.delegate = self
        companyEmailAddressTextField.delegate = self
        
        companyEmailAddressTextField.delegate = self
        companyPasswordTextField.delegate = self
        companyConfirmPasswordTextField.delegate = self
        
        self.view.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        termsAndPrivacyContainer.backgroundColor = #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        
        setUpView()
        

        
        
    }
    
   
    
    
    
    @IBAction func backToLoginVC(_ sender: Any) {
        
        Utilities.vibrate()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let historyBookModalVC = storyboard.instantiateViewController(withIdentifier: "LoginID") as? LoginViewController
        historyBookModalVC?.modalPresentationStyle = .fullScreen
        present(historyBookModalVC!, animated: true, completion: nil)
    }
    
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        Utilities.vibrate()
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpView(){

        registerBtn.layer.cornerRadius = Constants.cornerRadius
        
        companyNameTextField.returnKeyType = .continue
        companyNameTextField.leftViewMode = .always
        companyNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        companyNameTextField.autocapitalizationType = .none
        companyNameTextField.autocorrectionType = .no
        companyNameTextField.layer.masksToBounds = true
        companyNameTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        companyNameTextField.layer.cornerRadius = Constants.cornerRadius
        companyNameTextField.layer.borderWidth = 2.0
        companyNameTextField.layer.borderColor = UIColor.white.cgColor
        
     
        
        companyAddressTextField.returnKeyType = .continue
        companyAddressTextField.leftViewMode = .always
        companyAddressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        companyAddressTextField.autocapitalizationType = .none
        companyAddressTextField.autocorrectionType = .no
        companyAddressTextField.layer.masksToBounds = true
        companyAddressTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        companyAddressTextField.layer.cornerRadius = Constants.cornerRadius
        companyAddressTextField.layer.borderWidth = 2.0
        companyAddressTextField.layer.borderColor = UIColor.white.cgColor
        
      
        
        companyPhoneNumberTextField.returnKeyType = .continue
        companyPhoneNumberTextField.leftViewMode = .always
        companyPhoneNumberTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        companyPhoneNumberTextField.autocapitalizationType = .none
        companyPhoneNumberTextField.autocorrectionType = .no
        companyPhoneNumberTextField.layer.masksToBounds = true
        companyPhoneNumberTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        companyPhoneNumberTextField.layer.cornerRadius = Constants.cornerRadius
        companyPhoneNumberTextField.layer.borderWidth = 2.0
        companyPhoneNumberTextField.layer.borderColor = UIColor.white.cgColor
        
 
        
        companyEmailAddressTextField.returnKeyType = .continue
        companyEmailAddressTextField.leftViewMode = .always
        companyEmailAddressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        companyEmailAddressTextField.autocapitalizationType = .none
        companyEmailAddressTextField.autocorrectionType = .no
        companyEmailAddressTextField.layer.masksToBounds = true
        companyEmailAddressTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        companyEmailAddressTextField.layer.cornerRadius = Constants.cornerRadius
        companyEmailAddressTextField.layer.borderWidth = 2.0
        companyEmailAddressTextField.layer.borderColor = UIColor.white.cgColor
        
        
        
        companyPasswordTextField.returnKeyType = .continue
        companyPasswordTextField.leftViewMode = .always
        companyPasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        companyPasswordTextField.autocapitalizationType = .none
        companyPasswordTextField.autocorrectionType = .no
        companyPasswordTextField.layer.masksToBounds = true
        companyPasswordTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        companyPasswordTextField.layer.cornerRadius = Constants.cornerRadius
        companyPasswordTextField.layer.borderWidth = 2.0
        companyPasswordTextField.layer.borderColor = UIColor.white.cgColor
        
        
        companyConfirmPasswordTextField.returnKeyType = .continue
        companyConfirmPasswordTextField.leftViewMode = .always
        companyConfirmPasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        companyConfirmPasswordTextField.autocapitalizationType = .none
        companyConfirmPasswordTextField.autocorrectionType = .no
        companyConfirmPasswordTextField.layer.masksToBounds = true
        companyConfirmPasswordTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        companyConfirmPasswordTextField.layer.cornerRadius = Constants.cornerRadius
        companyConfirmPasswordTextField.layer.borderWidth = 2.0
        companyConfirmPasswordTextField.layer.borderColor = UIColor.white.cgColor
        
        
        //==================placeholder color===============
        companyNameTextField.attributedPlaceholder = NSAttributedString(string: "Company Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        companyAddressTextField.attributedPlaceholder = NSAttributedString(string: "Address",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        companyPhoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "Phone Number",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        companyEmailAddressTextField.attributedPlaceholder = NSAttributedString(string: "E-mail Address",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        
        companyPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        companyConfirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Confirm Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        
        
        
    }
    
    
    
    // ====Set up frames in View did layout subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    
    //    @objc private func didTapRegisterButton(){
    //        //===Dismiss keyboard for all fields
    //        usernameField.resignFirstResponder()
    //        emailField.resignFirstResponder()
    //        passwordField.resignFirstResponder()
    //
    //        //=====Get contents of all the fields
    //        guard let username = usernameField.text, !username.isEmpty,
    //            let email = emailField.text, !email.isEmpty,
    //            let password = passwordField.text, !password.isEmpty,  password.count >= 8 else {
    //                return
    //        }
    //
    //
    //        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
    //
    //            DispatchQueue.main.async {
    //                if registered {
    //                    //Good to go
    //
    //                } else {
    //
    //                    //Failed
    //
    //
    //                }
    //
    //            }
    //
    //
    //        }
    //    }
    
}



extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        companyNameTextField.delegate = self
        companyAddressTextField.delegate = self
        companyPhoneNumberTextField.delegate = self
        companyEmailAddressTextField.delegate = self
        companyPasswordTextField.delegate = self
        companyConfirmPasswordTextField.delegate = self
        
        if(textField == companyNameTextField) {
            companyAddressTextField.becomeFirstResponder() //the password field will be focused
            
        }
        else if(textField == companyNameTextField){
            
            companyAddressTextField.becomeFirstResponder() //the password field will be focused
            
        }
        else if(textField == companyAddressTextField){
            
            companyPhoneNumberTextField.becomeFirstResponder() //the password field will be focused
            
        }
        else if(textField == companyPhoneNumberTextField){
            
            companyEmailAddressTextField.becomeFirstResponder() //the password field will be focused
            
        }
        
        else if(textField == companyEmailAddressTextField){
            
            companyPasswordTextField.becomeFirstResponder() //the password field will be focused
            
        }
        
        else if(textField == companyPasswordTextField){
            
            
            companyConfirmPasswordTextField.becomeFirstResponder() //the password field will be focused
            
            
            
        }
        
        else if(textField == companyConfirmPasswordTextField){
            
            
            //perform sign up here
            
        }
        
        
        
        return true
    }
}
