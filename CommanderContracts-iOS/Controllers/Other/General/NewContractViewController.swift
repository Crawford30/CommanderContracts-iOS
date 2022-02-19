//
//  NewContractViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/28/21.
//

import UIKit

class NewContractViewController: UIViewController, UITextViewDelegate {
    
    let bgColor = UIColor.rgb(red: 157.0, green: 169.0, blue: 170.0, alpha: 1.0)
    
    let whiteColor = UIColor.rgb(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
    
    let blackColor = UIColor.rgb(red: 100.0, green: 100.0, blue: 100.0, alpha: 1.0)
   
    
    let datePicker: UIDatePicker = UIDatePicker()
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var clientAddressTextField: UITextField!
    @IBOutlet weak var clientNameTextField: UITextField!
    
    @IBOutlet weak var clientDateTextField: UITextField!
    @IBOutlet weak var contractPriceTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var contractDescriptionTexView: UITextView!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        clientDateTextField.rightView = textFieldBtn
//        clientDateTextField.rightViewMode = .always
        
        
        clientAddressTextField.delegate = self
        clientNameTextField.delegate = self
        clientDateTextField.delegate = self
        contractPriceTextField.delegate = self
        
        contractDescriptionTexView.delegate = self
        
        createDatePickerView()
        
        setUpViews()

        // Do any additional setup after loading the view.
    }
    
    
    
//    @objc func selectDateTapped() {
//
//        createDatePickerView()
//    }
//    
    

    @IBAction func backBtnTapped(_ sender: Any) {
        Utilities.vibrate()
        
        
        //https://stackoverflow.com/questions/30990507/dismiss-more-than-one-view-controller-simultaneously
        
       // self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        
        Utilities.vibrate()
        
        didTapNext()
    }
    
    
    
    private func didTapNext() {
        clientAddressTextField.resignFirstResponder()
        clientNameTextField.resignFirstResponder()
        clientDateTextField.resignFirstResponder()
        contractPriceTextField.resignFirstResponder()
        
        
        
        //=====Get contents of all the fields
        let clientName = clientNameTextField.text
        let clientAddress = clientAddressTextField.text
        let clientDate = clientDateTextField.text
        let clientDesc = contractDescriptionTexView.text
        let clientPrice = contractPriceTextField.text
        
        
        
        if (clientName?.isEmpty)! ||
            (clientAddress?.isEmpty)! ||
            (clientDesc?.isEmpty)! ||
            (clientDate?.isEmpty)! ||
            (clientPrice?.isEmpty)!
        {
            //=========display alert messages and return============
            self.displayMessage(title: "Error", userMessage: "All fields are required")
            return
        }
        
        
        let singleInstance = ClientOrUserSingleton.shared
        
     
        
        singleInstance.setClientName(theName: (clientName)!)
        singleInstance.setClientAddress(theAddress: (clientAddress)!)
        singleInstance.setContractDate(theDate: (clientDate)!)
        singleInstance.setContractDescription(theDesc: (clientDesc)!)
        singleInstance.setContractAmount(theAmount: (clientPrice!).toDouble()!)
        
        resetTextField()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "CaptureSignatureID") as? CaptureSignaturesViewController
        homeVC?.modalPresentationStyle = .fullScreen
        self.present(homeVC!, animated: true, completion: nil)
        
       
        
        
        
        
        
    }
    
    
  private  func resetTextField(){
    
    clientNameTextField.text?.removeAll()
    clientAddressTextField.text?.removeAll()
    clientDateTextField.text?.removeAll()
    contractDescriptionTexView.text?.removeAll()
    contractPriceTextField.text?.removeAll()
    
    }
    
    private func setUpViews() {
        
       
        self.view.backgroundColor = bgColor
        
        nextBtn.layer.cornerRadius = Constants.cornerRadius
        
        
        
        clientNameTextField.attributedPlaceholder = NSAttributedString(string: "Client Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        clientNameTextField.returnKeyType = .continue
        clientNameTextField.leftViewMode = .always
        clientNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        clientNameTextField.autocapitalizationType = .none
        clientNameTextField.autocorrectionType = .no
        clientNameTextField.layer.masksToBounds = true
        clientNameTextField.backgroundColor = bgColor
            
            //#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //.secondarySystemBackground
        clientNameTextField.layer.cornerRadius = Constants.cornerRadius
        clientNameTextField.layer.borderWidth = 2.0
        clientNameTextField.layer.borderColor = whiteColor.cgColor
        
        
        
        
        clientAddressTextField.attributedPlaceholder = NSAttributedString(string: "Client Address",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        clientAddressTextField.returnKeyType = .continue
        clientAddressTextField.leftViewMode = .always
        clientAddressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        clientAddressTextField.autocapitalizationType = .none
        clientAddressTextField.autocorrectionType = .no
        clientAddressTextField.layer.masksToBounds = true
        clientAddressTextField.backgroundColor =  bgColor
            
            //#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //.secondarySystemBackground
        clientAddressTextField.layer.cornerRadius = Constants.cornerRadius
        clientAddressTextField.layer.borderWidth = 2.0
        clientAddressTextField.layer.borderColor = UIColor.white.cgColor
        
        
        
        clientDateTextField.attributedPlaceholder = NSAttributedString(string: "Click to select date",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        clientDateTextField.returnKeyType = .continue
        clientDateTextField.leftViewMode = .always
        clientDateTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        clientDateTextField.autocapitalizationType = .none
        clientDateTextField.autocorrectionType = .no
        clientDateTextField.layer.masksToBounds = true
        clientDateTextField.backgroundColor = bgColor
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //.secondarySystemBackground
        clientDateTextField.layer.cornerRadius = Constants.cornerRadius
        clientDateTextField.layer.borderWidth = 2.0
        clientDateTextField.layer.borderColor = whiteColor.cgColor
           // UIColor.white.cgColor
        
        
        
      
        
        contractDescriptionTexView.text = "Description"
        contractDescriptionTexView.textColor = UIColor.darkGray
        
        
        
        contractDescriptionTexView.leftSpace()
        
        contractDescriptionTexView.autocapitalizationType = .none
        contractDescriptionTexView.autocorrectionType = .no
        contractDescriptionTexView.layer.masksToBounds = true
        contractDescriptionTexView.backgroundColor = bgColor
            //#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //.secondarySystemBackground
        contractDescriptionTexView.layer.cornerRadius = Constants.cornerRadius
        contractDescriptionTexView.layer.borderWidth = 2.0
        contractDescriptionTexView.layer.borderColor = whiteColor.cgColor
            
            //UIColor.white.cgColor
        
        
        
        
        contractPriceTextField.attributedPlaceholder = NSAttributedString(string: "Price (In USD)",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        contractPriceTextField.returnKeyType = .continue
        contractPriceTextField.leftViewMode = .always
        contractPriceTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        contractPriceTextField.autocapitalizationType = .none
        contractPriceTextField.autocorrectionType = .no
        contractPriceTextField.layer.masksToBounds = true
        contractPriceTextField.backgroundColor = bgColor
            
            //#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //.secondarySystemBackground
        contractPriceTextField.layer.cornerRadius = Constants.cornerRadius
        contractPriceTextField.layer.borderWidth = 2.0
        contractPriceTextField.layer.borderColor = whiteColor.cgColor
            
            //UIColor.white.cgColor
        
        
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
    
    
    
    
    
    
    
    
    
    
    
    func createDatePickerView() {
        
        //=====creating tool bar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //customize the toolbar
        toolBar.barStyle      = UIBarStyle.default
        toolBar.isTranslucent = true
//        toolBar.tintColor     = UIColor(named: "myToolbarTintColor")
        toolBar.tintColor     = UIColor.rgb(red: 76.0, green: 217.0, blue: 100.0, alpha: 1.0)
            
            //UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        //=======creating done button ===
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolBar.setItems([doneBtn], animated: true)
        
        //======space between done and cancel buttons
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //===cancel button ==
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(canclePressed))
        
        
        toolBar.setItems([cancelBtn, flexSpace, doneBtn], animated: true)
        
        //assign toolbar to the keyboard
        
        clientDateTextField.inputAccessoryView = toolBar
        
        //asign datepicker to the text field
        clientDateTextField.inputView = datePicker
        
        //date picker mode
        datePicker.datePickerMode = .date
        
        //datePicker.minimumDate = Date() //Hide past Date
        //datePicker.maximumDate = Date() //Hide future Date
        
    }
    
    @objc func canclePressed() {
        
        clientDateTextField.resignFirstResponder()
        
    }
    
    @objc func donePressed() {
        
        //format the text when done is pressed
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none  //includes the time when selected hence none removes it
        formatter.calendar = .current
        
        //2 things to be done: we assign the value to textfield and close the view
        //serviceDatePickerTextField.text = "\(datePicker.date)"
        
        
        clientDateTextField.text = formatter.string(from: datePicker.date)
        
        self.view.endEditing(true)
        
    }
    
  
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contractDescriptionTexView.textColor == UIColor.darkGray {
            contractDescriptionTexView.text = nil
            contractDescriptionTexView.textColor = UIColor.black
        }
    }
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if contractDescriptionTexView.text.isEmpty {
//            contractDescriptionTexView.text = "Description"
//            contractDescriptionTexView.textColor = UIColor.black
//        }
//    }
    
    
    
}



extension NewContractViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        clientAddressTextField.delegate = self
        clientNameTextField.delegate = self
        clientDateTextField.delegate = self
        contractPriceTextField.delegate = self
        
        contractDescriptionTexView.delegate = self
        
        if(textField == clientNameTextField) {
            clientAddressTextField.becomeFirstResponder() //the password field will be focused
        }
        
        
        if(textField == clientAddressTextField) {
            clientDateTextField.becomeFirstResponder() //the password field will be focused
        }
        else if(textField == clientDateTextField){
            
            contractDescriptionTexView.becomeFirstResponder() //the password field will be focused
        }
        else if(textField == contractDescriptionTexView){
            
            contractPriceTextField.becomeFirstResponder() //the password field will be focused
        }
      
        
       
        else if(textField == contractPriceTextField){
            
            //perform sign up here
            
            didTapNext()
        }
        
        return true
    }
    
    
    
   
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == contractPriceTextField{
        let isNumber = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        let withDecimal = (
            string == NumberFormatter().decimalSeparator &&
            textField.text?.contains(string) == false
        )
            
       
        return isNumber || withDecimal
            
        }
        
        return true
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        contractPriceTextField.delegate = self
//        //For mobile numer validation
//        if textField == contractPriceTextField {
//            let allowedCharacters = CharacterSet(charactersIn:"+0123456789.")//Here change this characters based on your requirement
//            let characterSet = CharacterSet(charactersIn: string)
//            return allowedCharacters.isSuperset(of: characterSet)
//        }
//        return true
//    }
    
    
}
