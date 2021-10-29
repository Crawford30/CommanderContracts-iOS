//
//  CaptureSignaturesViewController.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/28/21.
//

import UIKit


class CaptureSignaturesViewController: UIViewController, ImageInfoClientViewControllerDelegate, ImageInfoContractorViewControllerDelegate {
    
    
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
    }
    
    
    private func setUpViews() {
        
        self.view.backgroundColor =  #colorLiteral(red: 0.61176471, green: 0.6627451, blue: 0.66666667,alpha: 1.0)
        
        captureContractorSignBtn.layer.cornerRadius = Constants.cornerRadius
        
        
        captureClientSignBtn.layer.cornerRadius = Constants.cornerRadius
        
        
        submitBtn.layer.cornerRadius = Constants.cornerRadius
        
        
        contractorImageView.layer.cornerRadius = Constants.cornerRadius
        clientImageView.layer.cornerRadius = Constants.cornerRadius
        
        
    }
    
    
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
    
    
    
}
