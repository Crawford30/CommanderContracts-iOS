//
//  CaptureSignaturesViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/28/21.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class CaptureSignaturesViewController: UIViewController, ImageInfoClientViewControllerDelegate, ImageInfoContractorViewControllerDelegate {
    
    var companyEmail: String = ""
    var companyAddress: String = ""
    var companyName: String = ""
    var companyPhone: String = ""
    var userUID: String = ""
    
    var clientName: String = ""
    var clientAddress: String = ""
    var clientDate: String = ""
    var clientDesc: String = ""
    var clientPrice: String = ""
    var clientID: String = ""
    var id: String = ""
    
    
    
    
    
    
    var indicator:ProgressIndicator?
    
    
    var ref: DatabaseReference!
    var userRef: DatabaseReference!
    
    var clientSignUri: String = ""
    
    var contractorSignUri: String = ""
    
    func userSignature(image: UIImage) {
        print("CLIENT IMAGE: \(image)")
        clientImageView.image = image
    }
    
    
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    @IBOutlet weak var captureContractorSignBtn: UIButton!
    @IBOutlet weak var contractorImageView: UIImageView!
    
    @IBOutlet weak var clientImageView: UIImageView!
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var captureClientSignBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSentData()
        
        currentLoggedInUserData()
        
        setUpViews()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        Utilities.vibrate()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func captureContractorSignAction(_ sender: Any) {
        
        UserDefaults.standard.set(true, forKey: "WhoseSign")
        
        Utilities.vibrate()
        
        gotToSignaturePad()
    }
    
    
    @IBAction func captureClientSignAction(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "WhoseSign")
        
        
        Utilities.vibrate()
        
        gotToSignaturePad()
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        Utilities.vibrate()
        
        
        if(contractorImageView.isEmpty){
            self.displayMessage(title: "Error", userMessage: "Contractor Signature Required")
            return
        }
        
        if(clientImageView.isEmpty){
            self.displayMessage(title: "Error", userMessage: "Client Signature Required")
            return
        }
        
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Saving Contract...")
        self.view.addSubview(self.indicator!)
        indicator!.center = view.center
        indicator!.start()
        view.isUserInteractionEnabled = false
        
        
        
        
        
        
        //========Submit Data to firebase =====
        
        var currentFileName = NSDate().timeIntervalSince1970 * 1000
        
     
            if let data = clientImageView.image?.pngData() {
                // convert your UIImage into Data object using png representation
                
                
                var number = arc4random_uniform(900000) + 100000
                FirebaseStorageManager().uploadImageData(data: data, serverFileName: "\(number)" + ".png") { (isSuccess, url) in
                    
                    if(isSuccess){
                        
                        print("uploadImageData: \(isSuccess), \(url)")
                        
                        self.clientSignUri = url!
                        
                        
                        if let contractorData = self.contractorImageView.image?.pngData() {
                            // convert your UIImage into Data object using png representation
                            var number = arc4random_uniform(900000) + 100000
                            FirebaseStorageManager().uploadImageData(data: contractorData, serverFileName: "\(number)" + ".png") { (isSuccess, url) in
                                
                                if(isSuccess){
                                    
                                    print("uploadImageData: \(isSuccess), \(url)")
                                    self.contractorSignUri = url!
                                    
                                    
                                    Services.uploadContractsToDatabase(clientAddress: self.clientAddress, clientDate: self.clientDate, clientDesc: self.clientDesc, clientID: self.clientID, clientName: self.clientName, clientPrice: self.clientPrice, clientSignUri: self.clientSignUri, companyAddress: self.companyAddress, companyEmail: self.companyEmail, companyName: self.companyName, contractorSignUri: self.contractorSignUri, id: self.userRef.key!)
                                    {
                                        
                                        self.indicator!.stop()
                                        self.view.isUserInteractionEnabled = true
                                        
                                        //====Navigate to Existing Contracts
                                        
                                        
                                        //clear the image view
                                        self.clientImageView.image = nil
                                        self.contractorImageView.image = nil
                                        
                                        
                                        self.navigateToExistingContracts()
                                        
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                
                            
                            }
                        }
                        
                    }
                  
                }
            }
            
            //usersRef!!.key!!,
        
        
    
            
            
           
            
            //===========Save DAta======
            
            
          
            
            
           
        
        
        
        
        
        
        
        
    }
    
    private func navigateToExistingContracts(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "ExistingContractsID") as? ExistingContractsViewController
        homeVC?.modalPresentationStyle = .fullScreen
        self.present(homeVC!, animated: true, completion: nil)
        
    }
    
    
    private func setUpViews() {
        self.view.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        captureContractorSignBtn.layer.cornerRadius = Constants.cornerRadius
        captureClientSignBtn.layer.cornerRadius = Constants.cornerRadius
        submitBtn.layer.cornerRadius = Constants.cornerRadius
        contractorImageView.layer.cornerRadius = Constants.cornerRadius
        clientImageView.layer.cornerRadius = Constants.cornerRadius
    }
    
    
    
    private func currentLoggedInUserData() {
        
        
        
        ref = Database.database().reference()
        
        let userID : String = (Auth.auth().currentUser?.uid)!
        
        clientID = (Auth.auth().currentUser?.uid)!
        
        userRef = Database.database().reference().child("/user-contracts/\(String(describing: clientID))").childByAutoId()
        
        print("Current user ID is" + userID)
        
        self.ref?.child("users").child(userID).observeSingleEvent(of: .value, with: { [self](snapshot) in
            //            print(snapshot.value)
            
            companyEmail = (snapshot.value as! NSDictionary)["companyEmail"] as! String
            companyAddress = (snapshot.value as! NSDictionary)["companyAddress"] as! String
            companyName = (snapshot.value as! NSDictionary)["companyName"] as! String
            companyPhone = (snapshot.value as! NSDictionary)["companyPhone"] as! String
            userUID = (snapshot.value as! NSDictionary)["uid"] as! String
            
            print("\(companyEmail) -\(companyAddress) -\(companyName) -\(companyPhone) -\(userUID)" )
            
            
        })
        
    }
    
    
    private func getSentData(){
        
        let singleInstance = ClientOrUserSingleton.shared
        clientName = singleInstance.getClientName()
        clientAddress = singleInstance.getClientAddress()
        clientDate = singleInstance.getContractDate()
        clientDesc = singleInstance.getContractDescription()
        clientPrice = String(singleInstance.getContractAmount())
        
        
    }
    
    
    
    
    
    
    
    
    
    
    //    /// - Parameter digit: the number of digit
    //    /// - Returns: the ramdom generate number or nil if wrong parameter
    //    func randomNumber(with digit: Int) -> Int? {
    //
    //        guard 0 < digit, digit < 20 else { // 0 digit number don't exist and 20 digit Int are to big
    //            return nil
    //        }
    //
    //        /// The final ramdom generate Int
    //        var finalNumber : Int = 0;
    //
    //        for i in 1...digit {
    //
    //            /// The new generated number which will be add to the final number
    //            var randomOperator : Int = 0
    //
    //            repeat {
    //                #if os(Linux)
    //                    randomOperator = Int(random() % 9) * Int(powf(10, Float(i - 1)))
    //                #else
    //                    randomOperator = Int(arc4random_uniform(9)) * Int(powf(10, Float(i - 1)))
    //                #endif
    //
    //            } while Double(randomOperator + finalNumber) > Double(Int.max) // Verification to be sure to don't overflow Int max size
    //
    //            finalNumber += randomOperator
    //        }
    //
    //        return finalNumber
    //    }
    //
    
    func didSelectContractorImage(_ image: UIImage) {
        contractorImageView.image = image
    }
    
    func didSelectClientImage(_ image: UIImage) {
        clientImageView.image = image
    }
    
    
    private func gotToSignaturePad() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "SignaturePadID") as? SignaturePadViewController
        homeVC?.clientdelegate = self
        homeVC?.contractordelegate = self
        homeVC?.modalPresentationStyle = .fullScreen
        self.present(homeVC!, animated: true, completion: nil)
        
        
    }
    
    
    
    //============function to display alert messages==================
    private   func displayMessage(title: String, userMessage: String ) -> Void {
        
        DispatchQueue.main.async {
            
            Utilities.vibrateOnNotificationError()
            
            let alertController = UIAlertController (title: title, message: userMessage, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    
    
}




