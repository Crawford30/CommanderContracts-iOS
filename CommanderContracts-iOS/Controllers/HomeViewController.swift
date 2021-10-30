//
//  ViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/16/21.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    
    @IBOutlet weak var newOrExistingLabel: UILabel!
    @IBOutlet weak var createContractBtn: UIButton!
    
    @IBOutlet weak var viewExistingContractBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpViews()
        
        
       
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
    
    
    
    
    private func setUpViews() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "commanderlogo.jpg")!)
        createContractBtn.layer.cornerRadius = Constants.cornerRadius
        viewExistingContractBtn.layer.cornerRadius = Constants.cornerRadius
        
    }
    
    
    
    @IBAction func createNewContractAction(_ sender: Any) {
        Utilities.vibrate()
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "NewContractID") as? NewContractViewController
        homeVC?.modalPresentationStyle = .fullScreen
        self.present(homeVC!, animated: true, completion: nil)
        
        //
    }
    
    @IBAction func viewExistingContractAction(_ sender: Any) {
        Utilities.vibrate()
        
        navigateToExistingContracts()
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
    
    
    private func navigateToExistingContracts(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "ExistingContractsID") as? ExistingContractsViewController
        homeVC?.modalPresentationStyle = .fullScreen
        self.present(homeVC!, animated: true, completion: nil)
        
    }
    
    
}

