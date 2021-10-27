//
//  RegisterViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/18/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class RegisterViewController: UIViewController {
    var ref: DatabaseReference!
    
    var indicator:ProgressIndicator?
    
    
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var companyAddressTextField: UITextField!
    @IBOutlet weak var companyPhoneNumberTextField: UITextField!
    @IBOutlet weak var companyEmailAddressTextField: UITextField!
    @IBOutlet weak var companyPasswordTextField: TogglePassword!
    @IBOutlet weak var companyConfirmPasswordTextField: TogglePassword!
    @IBOutlet weak var termsAndPrivacyContainer: UIView!
    
    @IBOutlet weak var registerBtn: UIButton!
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        
        
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
    
    
    
    
    @IBAction func registerBtnAction(_ sender: Any) {
        
        Utilities.vibrate()
        
        didTapRegisterButton()
    }
    
    
    
    
    
    @IBAction func backToLoginVC(_ sender: Any) {
        
        Utilities.vibrate()
        navigateToLogin()
    }
    
    
    func navigateToLogin(){
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
    
    
    @objc private func didTapRegisterButton(){
        //===Dismiss keyboard for all fields
        companyNameTextField.resignFirstResponder()
        companyAddressTextField.resignFirstResponder()
        companyPhoneNumberTextField.resignFirstResponder()
        companyEmailAddressTextField.resignFirstResponder()
        companyPasswordTextField.resignFirstResponder()
        companyConfirmPasswordTextField.resignFirstResponder()
        
        
        //=====Get contents of all the fields
        let comName = companyNameTextField.text
        let comAddress = companyAddressTextField.text
        let comEmail = companyEmailAddressTextField.text
        let comPhone = companyPhoneNumberTextField.text
        let comPasswordOne = companyPasswordTextField.text
        let comPasswordTwo = companyConfirmPasswordTextField.text
        
        
        if (comName?.isEmpty)! ||
            (comAddress?.isEmpty)! ||
            (comEmail?.isEmpty)! ||
            (comPhone?.isEmpty)! ||
            (comPasswordOne?.isEmpty)! ||
            (comPasswordTwo?.isEmpty)!
        {
            //=========display alert messages and return============
            self.displayMessage(title: "Error", userMessage: "All fields are required")
            return
        }
        
        
        
        
        //====checking for email and its format================
        let cleanedemail = comEmail!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isValid_Email(cleanedemail) == false {
            //  ==========alert messgae=========
            self.displayMessage(title: "Error", userMessage: "Please enter a valid E-mail")
            return
            
        }
        
        if(Utilities.isPhoneNumber(value: comPhone!) == false){
            
            //==========alert messgae=========
            self.displayMessage(title: "Error", userMessage: "Please enter a valid phone number")
            return
            
        }
        
        
        let cleanedpassword1 = comPasswordOne!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedpassword2 = comPasswordTwo!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        
        //=========checking for password length=======
        if Utilities.isPwdLenth(password: cleanedpassword1, confirmPassword: cleanedpassword2) == false {
            //======alert messages======
            
            self.displayMessage(title: "Error", userMessage: "Passwords should be at leaset 8 characters")
            return
        }
        
        
        //========================checking for match password=====================
        if Utilities.isPasswordSame(password: cleanedpassword1, confirmPassword: cleanedpassword2) == false {
            //========alert messages ===========
            self.displayMessage(title: "Error", userMessage: "Passwords do not match")
            return
            
        }
        
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Registering  user...")
        self.view.addSubview(indicator!)
        indicator!.center = view.center
        indicator!.start()
        view.isUserInteractionEnabled = false
        
        //userID
        
        Services.signUpUser(email: cleanedemail, password: cleanedpassword2, comName: comName!, comAddress: comAddress!, comPhone: comPhone!) {
            
            self.indicator!.stop()
            self.view.isUserInteractionEnabled = true
            
            //====Navigate to login
            
            self.navigateToLogin()
            
            
        } onError: { (error) in
            
            
            self.indicator!.stop()
            self.view.isUserInteractionEnabled = true
            
            self.displayMessage(title: "Registration Error", userMessage: "\(error) We're unable to register your account now! Please try again later")
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        //        guard let userID = Auth.auth().currentUser?.uid else { return }
        //
        //
        //        AuthManager.shared.registerNewUser( companyName: comName!, companyAddress: comAddress!, companyPhone: comPhone!, companyEmail: cleanedemail, password: cleanedpassword2) { registered in
        //
        //            DispatchQueue.main.async {
        //                if registered {
        //                    //Good to go
        //
        //
        //
        //                    self.indicator!.stop()
        //                    self.view.isUserInteractionEnabled = true
        //
        //                    //====Navigate to login
        //
        //                    self.navigateToLogin()
        //
        //
        //                } else {
        //
        //                    //Failed
        //
        //                    self.indicator!.stop()
        //                    self.view.isUserInteractionEnabled = true
        //
        //                    self.displayMessage(title: "Registration Error", userMessage: "We're unable to register your account now! Please try again later")
        //
        //
        //                }
        //
        //            }
        //
        //
        //        }
        
        
        
        
        
        
        
        //        Auth.auth().createUser(withEmail: cleanedemail, password: cleanedpassword2) { (authData, error) in
        //            if let error = error {
        //                debugPrint("FIREBASE ERROR : \(error.localizedDescription)")
        //            } else {
        //                if let authData = authData {
        //                    let user = authData.user //here get the user from result
        //
        //                    let userData = ["companyAddress": comAddress! ,
        //                                    "companyEmail": cleanedemail,
        //                                    "companyLogoImageUrl": "https://firebasestorage.googleapis.com/v0/b/com...",
        //                                    "companyName": comName!,
        //                                    "companyPhone": comPhone!,
        //                                    "uid": Auth.auth().currentUser!.uid
        //
        //                    ]
        //
        //
        //                    self.ref.child("users").child(user.uid).setValue(userData)
        //
        //                                  self.indicator!.stop()
        //                                  self.view.isUserInteractionEnabled = true
        //
        //                                  //====Navigate to login
        //
        //                                  self.navigateToLogin()
        //
        //
        //
        //                }
        //            }
        //        }
        
        
        
        
        
        
        
        
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
            
            didTapRegisterButton()
        }
        
        return true
    }
    
    
}
