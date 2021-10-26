//
//  Utilities.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/23/21.
//



import Foundation
import UIKit


@available(iOS 10.0, *)
@available(iOS 11.0, *)

class  Utilities {
    
    
    //Adding Light haptic feedback for button tapped
    
    static func vibrate() {
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()  //removes the small delay in the feedback
        generator.impactOccurred()
    }
    
    //===============Selection selectionChanged
    
    static func vibrateOnSelect() {
        let selectionGenerator = UISelectionFeedbackGenerator()
        selectionGenerator.prepare()  //removes the small delay in the feedback
        selectionGenerator.selectionChanged()
    }
    
    
    
    
    
    //=======NotificationFeedBack Generator 3 cases, success, warning and error
    
    //on success
    static func vibrateOnNotificationSuccess() {
        let notificationGenerator = UINotificationFeedbackGenerator()
        notificationGenerator.prepare() //remove delay
        notificationGenerator.notificationOccurred(.success)
        
    }
    
    
    
    //on warning
    
    static func vibrateOnNotificationWarning() {
        
        let notificationGenerator = UINotificationFeedbackGenerator()
        notificationGenerator.prepare() //remove delay
        notificationGenerator.notificationOccurred(.warning)
    }
    
    
    
    // on error
    static func vibrateOnNotificationError() {
        let notificationGenerator = UINotificationFeedbackGenerator()
        notificationGenerator.prepare() //remove delay
        notificationGenerator.notificationOccurred(.error)
    }
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
}







