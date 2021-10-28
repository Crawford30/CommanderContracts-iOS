//
//  NewContractViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/28/21.
//

import UIKit

class NewContractViewController: UIViewController, UITextViewDelegate {
    
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
        
        contractDescriptionTexView.delegate = self
        
        setUpViews()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnTapped(_ sender: Any) {
        Utilities.vibrate()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        
        Utilities.vibrate()
    }
    
    private func setUpViews() {
        
        self.view.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        nextBtn.layer.cornerRadius = Constants.cornerRadius
        
        
        
        clientNameTextField.attributedPlaceholder = NSAttributedString(string: "Client Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        clientNameTextField.returnKeyType = .continue
        clientNameTextField.leftViewMode = .always
        clientNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        clientNameTextField.autocapitalizationType = .none
        clientNameTextField.autocorrectionType = .no
        clientNameTextField.layer.masksToBounds = true
        clientNameTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //.secondarySystemBackground
        clientNameTextField.layer.cornerRadius = Constants.cornerRadius
        clientNameTextField.layer.borderWidth = 2.0
        clientNameTextField.layer.borderColor = UIColor.white.cgColor
        
        
        
        
        clientAddressTextField.attributedPlaceholder = NSAttributedString(string: "Client Address",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        clientAddressTextField.returnKeyType = .continue
        clientAddressTextField.leftViewMode = .always
        clientAddressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        clientAddressTextField.autocapitalizationType = .none
        clientAddressTextField.autocorrectionType = .no
        clientAddressTextField.layer.masksToBounds = true
        clientAddressTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //.secondarySystemBackground
        clientAddressTextField.layer.cornerRadius = Constants.cornerRadius
        clientAddressTextField.layer.borderWidth = 2.0
        clientAddressTextField.layer.borderColor = UIColor.white.cgColor
        
        
        
        clientDateTextField.attributedPlaceholder = NSAttributedString(string: "Click to select date",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        clientDateTextField.returnKeyType = .continue
        clientDateTextField.leftViewMode = .always
        clientDateTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        clientDateTextField.autocapitalizationType = .none
        clientDateTextField.autocorrectionType = .no
        clientDateTextField.layer.masksToBounds = true
        clientDateTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //.secondarySystemBackground
        clientDateTextField.layer.cornerRadius = Constants.cornerRadius
        clientDateTextField.layer.borderWidth = 2.0
        clientDateTextField.layer.borderColor = UIColor.white.cgColor
        
        
        
      
        
        contractDescriptionTexView.text = "Description"
        contractDescriptionTexView.textColor = UIColor.black
        
        contractDescriptionTexView.leftSpace()
        
        
        
        contractDescriptionTexView.autocapitalizationType = .none
        contractDescriptionTexView.autocorrectionType = .no
        contractDescriptionTexView.layer.masksToBounds = true
        contractDescriptionTexView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //.secondarySystemBackground
        contractDescriptionTexView.layer.cornerRadius = Constants.cornerRadius
        contractDescriptionTexView.layer.borderWidth = 2.0
        contractDescriptionTexView.layer.borderColor = UIColor.white.cgColor
        
        
        
        
        contractPriceTextField.attributedPlaceholder = NSAttributedString(string: "Price (In USD)",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        contractPriceTextField.returnKeyType = .continue
        contractPriceTextField.leftViewMode = .always
        contractPriceTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        contractPriceTextField.autocapitalizationType = .none
        contractPriceTextField.autocorrectionType = .no
        contractPriceTextField.layer.masksToBounds = true
        contractPriceTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
            
            //.secondarySystemBackground
        contractPriceTextField.layer.cornerRadius = Constants.cornerRadius
        contractPriceTextField.layer.borderWidth = 2.0
        contractPriceTextField.layer.borderColor = UIColor.white.cgColor
        
        
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contractDescriptionTexView.textColor == UIColor.black {
            contractDescriptionTexView.text = nil
            contractDescriptionTexView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if contractDescriptionTexView.text.isEmpty {
            contractDescriptionTexView.text = "Description"
            contractDescriptionTexView.textColor = UIColor.black
        }
    }
    
    
    
}
