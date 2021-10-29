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
    
   
    private var clientName:  String
    private var clientAddress:  String
    private var contractDate:  String
    private var contractDescription:  String
    private var contractAmount:  Double
    
    
    
    
    private  init() { //A  private initilaizer, means it can only be called this class
        
        clientName = ""
        clientAddress = ""
        contractDate = ""
        contractDescription = ""
        contractAmount = 0.0
        
        
    } //not to be accessed anywhere apart from this class
    
    
    
    func setClientName(theName: String) -> () {
        
        clientName = theName
        
    }
    
    
    func getClientName() -> String {
        
        return clientName
    }
    
    
    func setClientAddress(theAddress: String) -> () {
        
        clientAddress = theAddress
        
    }
    
    
    func getClientAddress() -> String {
        
        return clientAddress
    }
    
    
    
    func setContractDate(theDate: String) -> () {
        
        contractDate = theDate
        
    }
    
    
    func getContractDate() -> String {
        
        return contractDate
    }
    
    
    func setContractDescription(theDesc: String) -> () {
        
        contractDescription = theDesc
        
    }
    
    
    func getContractDescription() -> String {
        
        return contractDescription
    }
    
    
    
    func setContractAmount(theAmount: Int) -> () {
        
        contractAmount = Double(Int(theAmount))
        
    }
    
    
    func getContractAmount() -> Double {
        
        return contractAmount
    }
    
    
    
    
    
    
    
    
    
    
}
