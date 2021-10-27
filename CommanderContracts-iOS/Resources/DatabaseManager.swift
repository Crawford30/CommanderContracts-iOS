//
//  DatabaseManager.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/18/21.
//


import FirebaseDatabase
import FirebaseAuth

public class DatabaseManager{
    
    //=====Creating a single instance
    static let shared = DatabaseManager()
    
    //====Databse ref
    let databaseRef = Database.database().reference()
    
    // MARK: - Public
    
    ///Check if username and email is avaliable
    //-Parameters
    //   -email string representing email
    //   -username string representing username
    
    public func canCreateNewUser(with   companyName: String,  companyAddress: String,  companyPhone: String, companyEmail: String,  password: String, completion: (Bool) -> Void){
        
        completion(true)
        
        
        
    }
    
    
    
    //Insert new user data to Dataase
    //-Parameters
    //   -email string representing email
    //   -username string representing username
    // -completion : Async callback for result if database entry succeeded
    public func insertNewUser(with   companyName: String,  companyAddress: String,  companyPhone: String, companyEmail: String, completion: @escaping (Bool) -> Void) {
        
        // databaseRef.child("users").child(userID).setValue(["username" : username])
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        
        let userData = ["companyAddress": companyAddress ,
                        "companyEmail": companyEmail,
                        "companyLogoImageUrl": "https://firebasestorage.googleapis.com/v0/b/com...",
                        "companyName": companyName,
                        "companyPhone": companyPhone,
                        "uid": userID
                        
        ]
        
        print("CURRENT USED ID: \(userID)")
        
        
        //Making it with a Trailing clousre syntax
        databaseRef.child("users").child(userID).setValue(userData) { error,_  in
            
            if error == nil  {
                //succeeded
                print("NO ERROR ")
                
                completion(true)
                return
                
            }else {
                
                print("THIS IS ERROR: \(String(describing: error))")
                //Failed
                completion(false)
                return
                
            }
        }
        
        
    }
    
}


