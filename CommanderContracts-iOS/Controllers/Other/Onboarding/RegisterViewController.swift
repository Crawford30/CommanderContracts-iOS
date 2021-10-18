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
        
        
        setUpView()
        // Do any additional setup after loading the view.
        
        //        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        //        emailField.delegate = self
        //        usernameField.delegate = self
        //        passwordField.delegate = self
        //
        //        view.addSubview(usernameField)
        //        view.addSubview(emailField)
        //        view.addSubview(passwordField)
        //        view.addSubview(registerButton)
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
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
        companyNameTextField.backgroundColor = .secondarySystemBackground
        companyNameTextField.layer.cornerRadius = Constants.cornerRadius
        companyNameTextField.layer.borderWidth = 1.0
        companyNameTextField.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        
        
        
        companyAddressTextField.returnKeyType = .continue
        companyAddressTextField.leftViewMode = .always
        companyAddressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        companyAddressTextField.autocapitalizationType = .none
        companyAddressTextField.autocorrectionType = .no
        companyAddressTextField.layer.masksToBounds = true
        companyAddressTextField.backgroundColor = .secondarySystemBackground
        companyAddressTextField.layer.cornerRadius = Constants.cornerRadius
        companyAddressTextField.layer.borderWidth = 1.0
        companyAddressTextField.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        
        
        
        companyPhoneNumberTextField.returnKeyType = .continue
        companyPhoneNumberTextField.leftViewMode = .always
        companyPhoneNumberTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        companyPhoneNumberTextField.autocapitalizationType = .none
        companyPhoneNumberTextField.autocorrectionType = .no
        companyPhoneNumberTextField.layer.masksToBounds = true
        companyPhoneNumberTextField.backgroundColor = .secondarySystemBackground
        companyPhoneNumberTextField.layer.cornerRadius = Constants.cornerRadius
        companyPhoneNumberTextField.layer.borderWidth = 1.0
        companyPhoneNumberTextField.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        
        
        
        companyEmailAddressTextField.returnKeyType = .continue
        companyEmailAddressTextField.leftViewMode = .always
        companyEmailAddressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        companyEmailAddressTextField.autocapitalizationType = .none
        companyEmailAddressTextField.autocorrectionType = .no
        companyEmailAddressTextField.layer.masksToBounds = true
        companyEmailAddressTextField.backgroundColor = .secondarySystemBackground
        companyEmailAddressTextField.layer.cornerRadius = Constants.cornerRadius
        companyEmailAddressTextField.layer.borderWidth = 1.0
        companyEmailAddressTextField.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        
        
        companyPasswordTextField.returnKeyType = .continue
        companyPasswordTextField.leftViewMode = .always
        companyPasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        companyPasswordTextField.autocapitalizationType = .none
        companyPasswordTextField.autocorrectionType = .no
        companyPasswordTextField.layer.masksToBounds = true
        companyPasswordTextField.backgroundColor = .secondarySystemBackground
        companyPasswordTextField.layer.cornerRadius = Constants.cornerRadius
        companyPasswordTextField.layer.borderWidth = 1.0
        companyPasswordTextField.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        
        companyConfirmPasswordTextField.returnKeyType = .continue
        companyConfirmPasswordTextField.leftViewMode = .always
        companyConfirmPasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        companyConfirmPasswordTextField.autocapitalizationType = .none
        companyConfirmPasswordTextField.autocorrectionType = .no
        companyConfirmPasswordTextField.layer.masksToBounds = true
        companyConfirmPasswordTextField.backgroundColor = .secondarySystemBackground
        companyConfirmPasswordTextField.layer.cornerRadius = Constants.cornerRadius
        companyConfirmPasswordTextField.layer.borderWidth = 1.0
        companyConfirmPasswordTextField.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        
        
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
