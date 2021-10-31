//
//  ViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/16/21.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var floatBtn: UIButton!
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    
    @IBOutlet weak var newOrExistingLabel: UILabel!
    @IBOutlet weak var createContractBtn: UIButton!
    
    @IBOutlet weak var viewExistingContractBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        setupNavigationItems()
        
        
//        let label = UILabel()
//        label.textColor = UIColor.white
//        label.text = "Commander's Contracts"
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        floatBtn.createFloationgAction()
        
        setUpViews()
        
        
       
    }
    
    
    
    
    private func setupNavigationItems() {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Commander's Contracts"
        label.backgroundColor = .green
        
        label.textAlignment = .left
        
        navigationItem.titleView = label
        
        if let navigationBar = navigationController?.navigationBar {
            
            label.widthAnchor.constraint(equalTo: navigationBar.widthAnchor, constant: -40).isActive = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        handleNotAuthenticated()
        
    }
    
    @IBAction func signOutBtn(_ sender: Any) {
        Utilities.vibrate()
        
        
        
        let alert = UIAlertController(title: "LOG OUT\n", message: "Are you sure you need to Log Out?", preferredStyle: .alert)
        
        
        
        // Change font and color of title
        alert.setTitle(font: UIFont.boldSystemFont(ofSize: 26), color: UIColor.white)
        
        // Change font and color of message
        alert.setMessage(font: UIFont(name: "", size: 18), color: UIColor.white)
        
        
        // Change background color of UIAlertController
        
        //#colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        
        alert.setBackgroudColor(color: UIColor.secondaryLabel)
        
        
        // Accessing alert view backgroundColor :
        //alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.red
        
        alert.view.tintColor = UIColor.white
        
        
        
        
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (UIAlertAction) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "PROCEED", style: .default, handler: { (UIAlertAction) in
            
            
            
                    do {
                        try Auth.auth().signOut()
                        self.redirectToLogin()
                    }
                    catch{
                        print("Failed to signout")
                    }
                    
            
            
//            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
//
//            UserDefaults.standard.removeObject(forKey: "AccessToken")
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let rootVC = storyboard.instantiateViewController(withIdentifier: "LoginPage") as! ViewController
//
//            let nvc: UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "LoginNavController") as! UINavigationController
//
//
//            nvc.viewControllers = [rootVC]
//
//
//            UIApplication.shared.keyWindow?.rootViewController = nvc
//
            
            
        }))
        
        
        self.present(alert,animated: true, completion: nil)
        
        //        do {
        //            try Auth.auth().signOut()
        //            redirectToLogin()
        //        }
        //        catch{
        //            print("Failed to signout")
        //        }
                
        
        
    }
    
    
    
    
    private func setUpViews() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "commanderlogo.jpg")!)
        createContractBtn.layer.cornerRadius = Constants.cornerRadius
        viewExistingContractBtn.layer.cornerRadius = Constants.cornerRadius
        
    }
    
    
    @IBAction func floatActionBtnTapped(_ sender: Any) {
        
        goToCreateContract()
    }
    
    @IBAction func createNewContractAction(_ sender: Any) {
       goToCreateContract()
    }
    
    @IBAction func viewExistingContractAction(_ sender: Any) {
        Utilities.vibrate()
        
        navigateToExistingContracts()
    }
    
    
    private func goToCreateContract() {
        
        
        Utilities.vibrate()
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "NewContractID") as? NewContractViewController
        homeVC?.modalPresentationStyle = .fullScreen
        self.present(homeVC!, animated: true, completion: nil)
        
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

