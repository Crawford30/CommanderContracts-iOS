//
//  ClientOrUserSingleton.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/28/21.
//

import Foundation
import UIKit

class ClientOrUserSingleton {
    
    static let shared = ClientOrUserSingleton()
    
   
    private var clientSignature:  UIImage
    
    private var contractoreSignature: UIImage
    
    
    private  init() { //A  private initilaizer, means it can only be called this class
        
        clientSignature = UIImage()
        
         contractoreSignature = UIImage()
        
        
    } //not to be accessed anywhere apart from this class
    
    
    
    func setClientImage(theImage: UIImage) -> () { //set the usertype to the singleton, thats why it doest have return type
        
        clientSignature = theImage
        
    }
    
    
    func getClientImage() -> UIImage {
        
        return clientSignature
    }
    
    
    func setContractorImage(theImage: UIImage) -> () { //set the usertype to the singleton, thats why it doest have return type
        
        contractoreSignature = theImage
        
    }
    
    
    func getContractorImage() -> UIImage {
        
        return contractoreSignature
    }
    
    
}
