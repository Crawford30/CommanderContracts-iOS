//
//  ContractSingleton.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/30/21.
//



import Foundation
import UIKit

class ContractSingleton {
    
    static let shared = ContractSingleton()
    
    
    private var clientName:  String
    private var clientSignUrl:  String
    private var clientCompanyName:  String
    private var clientAddress:  String
    private var contractDate:  String
    private var contractDescription:  String
    private var contractAmount:  Double
    
    private var contractorName:  String
    private var contractorAddress:  String
    
    private var contractorSignUrl:  String
    private var contractorCompanyName:  String
    private var contractorEmail:  String
    
    
    
    private  init() { //A  private initilaizer, means it can only be called this class
        
        clientName = ""
        clientSignUrl = ""
        clientCompanyName = ""
        clientAddress = ""
        contractDate = ""
        contractDescription = ""
        contractAmount = 0.0
        
        contractorName = ""
        contractorAddress = ""
        
        contractorCompanyName = ""
        contractorEmail = ""
        contractorSignUrl = ""
        
    } //not to be accessed anywhere apart from this class
    
    
    
    func setClientName(theName: String) -> () {
        clientName = theName
    }
    
    
    func getClientName() -> String {
        return clientName
    }
    
    
    func setClientSignUri(theUri: String) -> () {
        clientSignUrl = theUri
    }
    
    
    func getClientSignUri() -> String {
        return clientSignUrl
    }
    
    func setClientCompanyName(theName: String) -> () {
        clientCompanyName = theName
    }
    
    
    func getClientCompanyName() -> String {
        return clientCompanyName
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
    
    
    
    func setContractorAddress(theAddress: String) -> () {
        contractorAddress = theAddress
    }
    
    
    func getContractorAddress() -> String {
        return contractorAddress
    }
    
    
    func setContractAmount(theAmount: Int) -> () {
        contractAmount = Double(Int(theAmount))
        
    }
    
    
    func getContractAmount() -> Double {
        
        return contractAmount
    }
    
    
    func setContractorName(theName: String) -> () {
        contractorName = theName
        
    }
    
    
    func getContractorName() -> String {
        return contractorName
    }
    
    
    func setContractorCompanyName(theName: String) -> () {
        contractorCompanyName = theName
        
    }
    
    
    func getContractorCompanyName() -> String {
        return contractorCompanyName
    }
    
    func setContractorEmail(theEmail: String) -> () {
        contractorEmail = theEmail
    }
    
    
    func getContractorEmail() -> String {
        return contractorEmail
    }
    
    
    func setContractorSignUrl(theUri: String) -> () {
        contractorSignUrl = theUri
        
    }
    
    
    func getContractorSignUrl() -> String {
        return contractorSignUrl
    }
    
    
    
    
}
