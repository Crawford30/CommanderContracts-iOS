//
//  ViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/16/21.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "commanderlogo.jpg")!)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        handleNotAuthenticated()
        
    }
    
    @IBAction func signOutBtn(_ sender: Any) {
        Utilities.vibrate()
        
        do {
            try Auth.auth().signOut()
            redirectToLogin()
        }
        catch{
            print("Failed to signout")
        }
        
        
        
    }
    
    
    
    
    
    private func handleNotAuthenticated(){
        //=====Check Auth Status by checking firebase session=======
        if(Auth.auth().currentUser == nil){
            
            redirectToLogin()
            
        }
        
    }
    
    
    private  func redirectToLogin(){
        //======Show Login Controller====
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let historyBookModalVC = storyboard.instantiateViewController(withIdentifier: "LoginID") as? LoginViewController
        historyBookModalVC?.modalPresentationStyle = .fullScreen
        present(historyBookModalVC!, animated: true, completion: nil)
        
    }
    
    
}

