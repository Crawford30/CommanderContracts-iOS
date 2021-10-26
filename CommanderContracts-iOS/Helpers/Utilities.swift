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
    
    
    //========validate email========
    static func isValidEmail(testStr:String) -> Bool {
        //print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
        
    }
    
    /// Validate email string
    ///
    /// - parameter email: A String that rappresent an email address
    ///
    /// - returns: A Boolean value indicating whether an email is valid.
    static func isValid_Email(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    //======validate password========
    static func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[a-zA-Z])(?=.*[0-9]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    //======passweord are the same======
    static func isPasswordSame(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword{
            
            return true
            
        } else {
            
            return false
        }
    }
    
    //========password length=====
    static func isPwdLenth(password: String , confirmPassword : String) -> Bool {
        
        if password.count >= 8 && confirmPassword.count >= 8 {
            return true
            
        } else {
            
            return false
        }
    }
    
    //======phone validation==========
    static  func isValidatePhone(value: String) -> Bool {
        
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    
    static func isPhoneNumber(value:String) -> Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: value, options: [], range: NSRange(location: 0, length: value.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == value.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    
    
    
    
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







