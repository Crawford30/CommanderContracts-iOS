//
//  LoginViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/18/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var resendCodeLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    //    @IBOutlet weak var genericView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forgotPasswordLabel.font = forgotPasswordLabel.font.italic
        
     
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
        signUpLabel.isUserInteractionEnabled = true
        
        self.view.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        //navBar.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        //        genericView.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        
        setUpView()
        
        
        
        
    }
    
    @IBAction func goToSignUpTapped(_ sender: Any) {
        
        Utilities.vibrate()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let historyBookModalVC = storyboard.instantiateViewController(withIdentifier: "RegisterID") as? RegisterViewController
        historyBookModalVC?.modalPresentationStyle = .fullScreen
        present(historyBookModalVC!, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        Utilities.vibrate()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func setUpView(){
        loginBtn.layer.cornerRadius = Constants.cornerRadius
        
        
        
        emailTextField.returnKeyType = .continue
        emailTextField.leftViewMode = .always
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.layer.masksToBounds = true
        emailTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            
            //.secondarySystemBackground
        emailTextField.layer.cornerRadius = Constants.cornerRadius
        emailTextField.layer.borderWidth = 2.0
        emailTextField.layer.borderColor = UIColor.white.cgColor
        
        
        
        
        passwordTextField.returnKeyType = .continue
        passwordTextField.leftViewMode = .always
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.layer.masksToBounds = true
        passwordTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //.secondarySystemBackground
        passwordTextField.layer.cornerRadius = Constants.cornerRadius
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        
        
    }
    
    
    
    @IBAction func loginBtnAction(_ sender: Any) {
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
    }
    
    
    
    
    
    
    
    
    
    //    //MARK:- Button Functions
    //    @objc private func didTapLogginButton(){
    //        print("Login Button tapped!")
    //        //When Logged in btn is tapped,,dismiss the Keyboard
    //        passwordField.resignFirstResponder()
    //        usernameEmailField.resignFirstResponder()
    //
    //        //check we have text
    //        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
    //            let password = passwordField.text, !password.isEmpty, password.count >= 8
    //            else {
    //                return
    //        }
    //
    //        //====Passed to login function ===
    //        var username: String?
    //        var email: String?
    //
    //        //=====Figure wether to pass email or username
    //        if usernameEmail.contains("@"), usernameEmail.contains(".") {
    //            //its email
    //            email = usernameEmail
    //
    //            print("This is the user email: \(email!)")
    //
    //        }else {
    //            //username
    //            username = usernameEmail
    //            print("This is the user name: \(username!)")
    //
    //        }
    //
    //        //=======Login function===
    //        AuthManager.shared.loginUser(username: username, email: email, password: password) {success in
    //            //=====The closure should be called on the main thread
    //            DispatchQueue.main.async {
    //
    //                if success {
    //                    //user logged in,, Dismiss the current VC
    //                    self.dismiss(animated: true, completion: nil)
    //                } else {
    //                    //Error occured, show alert view
    //                    let alert = UIAlertController(title: "Login Error", message: "We're unable to log you in!", preferredStyle: .alert)
    //
    //                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    //
    //                    self.present(alert, animated: true, completion: nil)
    //                }
    //            }
    //        }
    //    }
    //
    
    
    //    @objc private func didTapTermsButton(){
    //        print("Terms Button tapped!")
    //
    //        guard let url = URL(string: "https://www.instagram.com/about/legal/terms/before-january-19-2013/") else {
    //            return
    //        }
    //
    //        let vc = SFSafariViewController(url: url)
    //        present(vc, animated: true, completion: nil)
    //
    //    }
    
    
    
    //    @objc private func didTapPrivacyButton(){
    //        guard let url = URL(string: "https://www.elitedaily.com/p/what-is-instagrams-privacy-policy-heres-what-to-know-about-the-apps-rules-18689769") else {
    //            return
    //        }
    //
    //        let vc = SFSafariViewController(url: url)
    //        present(vc, animated: true, completion: nil)
    //
    //    }
    
    
    
    
    
    
    //    @objc private func didTapCreateAccountButton(){
    //        let vc = RegisterViewController()
    //        vc.title = "Create Account"
    //        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    //
    //
    //    }
    
    
    
    
    
}


extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == emailTextField) {
            passwordTextField.becomeFirstResponder() //the password field will be focused
            
        }
        else if(textField == passwordTextField){
            
            //didTapLogginButton()
            
        }
        
        return true
    }
}
