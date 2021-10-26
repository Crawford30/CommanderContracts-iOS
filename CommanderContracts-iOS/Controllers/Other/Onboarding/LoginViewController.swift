//
//  LoginViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/18/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    var indicator:ProgressIndicator?
    
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
        
        self.view.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        forgotPasswordLabel.font = forgotPasswordLabel.font.italic
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
        signUpLabel.isUserInteractionEnabled = true
        
        forgotPasswordLabel.isUserInteractionEnabled = true
        
        resendCodeLabel.isUserInteractionEnabled = true
        
        
        
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
    @IBAction func forgotPasswordVC(_ sender: Any) {
        
        Utilities.vibrate()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let historyBookModalVC = storyboard.instantiateViewController(withIdentifier: "ResetPasswordID") as? ResetPasswordViewController
        historyBookModalVC?.modalPresentationStyle = .fullScreen
        present(historyBookModalVC!, animated: true, completion: nil)
        
    }
    
    @IBAction func resendVerificationTapped(_ sender: Any) {
        
        Utilities.vibrate()
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
        
        
        //==================placeholder color===============
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail Address",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        
        
    }
    
    
    
    @IBAction func loginBtnAction(_ sender: Any) {
        Utilities.vibrate()
        
        didTapLogginButton()
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
    }
    
    
    
    
    private func didTapLogginButton() {
        print("Login Button tapped!")
        //When Logged in btn is tapped,,dismiss the Keyboard
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        
        
        if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
            
            self.displayMessage(title: "Error", userMessage: "All fields are required")
            
        }
        
        //check we have text
        guard let userEmail = emailTextField.text, !userEmail.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 8
        else {
            return
        }
        
        //====Passed to login function ===
        var username: String?
        var email: String?
        
        
        
        
        //=====Figure wether to pass email or username
        if userEmail.contains("@"), userEmail.contains(".") {
            //its email
            email = userEmail
            
            print("This is the user email: \(email!)")
            
        }else {
            //username
            username = userEmail
            print("This is the user name: \(username!)")
            
        }
        
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Logging in user...")
        self.view.addSubview(indicator!)
        indicator!.center = view.center
        indicator!.start()
        
        
        //=======Login function===
        AuthManager.shared.loginUser(username: username, email: email, password: password) {success in
            //=====The closure should be called on the main thread
            DispatchQueue.main.async {
                
                if success {
                    self.indicator!.stop()
                    
                    
                    //user logged in,, Dismiss the current VC
                    self.dismiss(animated: true, completion: nil)
                    
                } else {
                    
                    self.indicator!.stop()
                    
                    self.displayMessage(title: "Login Error", userMessage: "We're unable to log you in! Make sure the email and password are correct")
                    
                }
            }
        }
    }
    
    
    
    
    
    
    
    //============function to display alert messages==================
    func displayMessage(title: String, userMessage: String ) -> Void {
        
        DispatchQueue.main.async {
            
            Utilities.vibrateOnNotificationError()
            
            let alertController = UIAlertController (title: title, message: userMessage, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
  
    
}


extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == emailTextField) {
            passwordTextField.becomeFirstResponder() //the password field will be focused
            
        }
        else if(textField == passwordTextField){
            
            didTapLogginButton()
            
        }
        
        return true
    }
}
