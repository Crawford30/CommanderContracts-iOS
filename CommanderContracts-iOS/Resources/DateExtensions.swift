//
//  DateExtensions.swift
//  Commander Contracts
//
//  Created by JOEL CRAWFORD on 11/27/21.
//





import Foundation
import UIKit



extension Date {
    

    static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: Date())

    }
    
    

        
    
    
    
}
