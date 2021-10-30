//
//  ExistingContractsViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/29/21.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ExistingContractsViewController: UIViewController {
    var clientID: String = ""
    var allContracts: [ MyContracts ] = []
    
    var ref: DatabaseReference!
    var userRef: DatabaseReference!
    
    override func viewDidLoad() {
        
        loadAllContracts()
        super.viewDidLoad()
        self.view.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        Utilities.vibrate()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func loadAllContracts() {
        
        ref = Database.database().reference()
        
        let userID : String = (Auth.auth().currentUser?.uid)!
        
        clientID = (Auth.auth().currentUser?.uid)!
        
        userRef = Database.database().reference().child("/user-contracts/\(String(describing: clientID))").childByAutoId()
        
        print("Current user ID is" + userID)
        
        
        
        
        
        self.ref?.child("/user-contracts/").child(userID).observe(.value, with: { snapshot in
            
            
            var tempID: MyContracts //the class
            
            self.allContracts = [] // Temporarily clear allContracts when loading new Sections
            
            
            for child in snapshot.children{
                
                tempID = MyContracts.init()
                
                let valueD = child as! DataSnapshot
                
                //                let keyD = valueD.key
                let value1 = valueD.value as? [String:String]
                
                
                tempID.clientAdress = (value1!["clientAddress"]!)
                tempID.clientDate = (value1!["clientDate"]!)
                tempID.clientDesc = (value1!["clientDesc"]!)
                tempID.cientID = (value1!["clientID"]!)
                tempID.clientName = (value1!["clientName"]!)
                tempID.clientPrice = (value1!["clientPrice"]!)
                tempID.clientProfile = (value1!["clientProfileLogoUri"]!)
                tempID.clientSignUrl = (value1!["clientSignUri"]!)
                tempID.companyAddress = (value1!["companyAddress"]!)
                tempID.companyEmail = (value1!["companyEmail"]!)
                tempID.companyName = (value1!["companyName"]!)
                tempID.contractorSignUrl = (value1!["contractorSignUri"]!)
                tempID.id = (value1!["id"]!)
                
                
                self.allContracts.append( tempID )
                
            }
            
            self.allContracts.sort {
                $0.clientName.lowercased() < $1.clientName.lowercased()
                
            }
            
            print(self.allContracts)
            
            
            
        })
        
        
        
    }
    
    
}
