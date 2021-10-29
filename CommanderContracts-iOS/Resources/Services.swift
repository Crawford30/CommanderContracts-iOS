//
//  Services.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/27/21.
//

import UIKit
import Firebase

class Services {
    
    static func signUpUser(email: String, password: String,comName: String, comAddress: String, comPhone: String,  onSuccess: @escaping () ->Void, onError: @escaping ( _ error:Error) ->Void ){
        
        let auth = Auth.auth()
        
        auth.createUser(withEmail: email, password: password) { (authResult, error) in
            
            if(error != nil){
                
                onError(error!)
                return
                
            }
            
            
            uploadToDatabase(comName: comName, comAddress: comAddress, comPhone: comPhone, comEmail: email, onSuccess: onSuccess)
            
        }
        
        
    }
    
    
    static func uploadToDatabase(comName: String, comAddress: String, comPhone: String,comEmail: String, onSuccess: @escaping () ->Void){
        
        let   ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        
        print("USERID: \(String(describing: uid))")
        
        let imgUrl = "https://firebasestorage.googleapis.com/v0/b/commander-s-contracts.appspot.com/o/images%2F36588d87-88a7-46d0-a86a-6d374be54040?alt=media&token=a4b5503e-9434-49ad-8ce6-bfc325244fe3"
        
        
        ref.child("users").child(uid!).setValue( ["companyAddress" : comAddress, "companyEmail": comEmail,  "companyLogoImageUrl": imgUrl, "companyName" : comName, "companyPhone" : comPhone, "uid": uid ])
        
        onSuccess()
        
        
    }
    
    
    
    
    
    static func uploadContractsToDatabase(clientAddress: String, clientDate: String, clientDesc: String,clientID: String, clientName: String, clientPrice: String,
                                          clientSignUri: String,companyAddress: String, companyEmail: String, companyName: String,
                                          contractorSignUri: String, id: String, onSuccess: @escaping () ->Void){
        
        let uid = Auth.auth().currentUser?.uid
        
        let   ref = Database.database().reference().child("/user-contracts/\(uid!)").childByAutoId()
        
        
        
        print("USERID: \(String(describing: uid))")
        
        let clientProfileLogoUri = "https://firebasestorage.googleapis.com/v0/b/commander-s-contracts.appspot.com/o/images%2F36588d87-88a7-46d0-a86a-6d374be54040?alt=media&token=a4b5503e-9434-49ad-8ce6-bfc325244fe3"
        
        
        let data = [ "clientAddress" : clientAddress,
                     "clientDate" : clientDate,
                     "clientDesc" : clientDesc,
                     "clientID" : clientID,
                     "clientName" : clientName,
                     "clientPrice" : clientPrice,
                     "clientProfileLogoUri" : clientProfileLogoUri,
                     "clientSignUri" : clientSignUri,
                     "companyAddress" : companyAddress,
                     "companyEmail" : companyEmail,
                     "companyName" : companyName,
                     "contractorSignUri" : contractorSignUri,
                     "id" : id,
                     
                     
                     
                     
        ]
        
        ref.setValue(data)
        
        
        
        
        
        //        ref.child("users").child(uid!).setValue( ["companyAddress" : comAddress, "companyEmail": comEmail,  "companyLogoImageUrl": imgUrl, "companyName" : comName, "companyPhone" : comPhone, "uid": uid ])
        
        onSuccess()
        
        
    }
    
    
    
    
}
