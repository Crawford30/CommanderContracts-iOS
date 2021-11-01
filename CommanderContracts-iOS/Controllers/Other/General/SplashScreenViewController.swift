//
//  SplashScreenViewController.swift
//  Commander Contracts
//
//  Created by JOEL CRAWFORD on 11/1/21.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var splashScreelLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.view.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        let backgroundLogo: UIImage = UIImage(named: "commanderlogo")!
        
        splashScreelLogo.maskCircle(anyImage: backgroundLogo)
        splashScreelLogo.image = backgroundLogo
    
        showSplashScreen()
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
    func showSplashScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeID") as? HomeViewController
            homeVC?.modalPresentationStyle = .fullScreen
//            self.present(homeVC!, animated: true, completion: nil)
            

            
            
            self.present(homeVC!, animated: true) {
                UIView.animate(withDuration: 1.0, delay: 0.5, options: .autoreverse, animations: {
                    self.view.alpha = 0
                }, completion: nil)
            }
        }
    }
    

   

}
