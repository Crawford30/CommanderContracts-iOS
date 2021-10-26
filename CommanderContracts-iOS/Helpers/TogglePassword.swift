//
//  TogglePassword.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/23/21.
//



import UIKit

class TogglePassword: UITextField {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    let rightButton  = UIButton(type: .custom)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        
        rightButton.setImage(UIImage(named: "view-password")?.withTintColor(UIColor.black) , for: .normal)
        rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        rightButton.frame = CGRect(x:12, y:10, width:((self.frame.height) * 0.50), height:((self.frame.height) * 0.50))
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        
        rightViewMode = .always
        rightView = rightButton
        isSecureTextEntry = true
       
    }
    
    @objc
    func toggleShowHide(button: UIButton) {
        toggle()
    }
    
    func toggle() {
        Utilities.vibrate()
        
        isSecureTextEntry = !isSecureTextEntry
        if isSecureTextEntry {
            rightButton.setImage(UIImage(named: "view-password")?.withTintColor(UIColor.black) , for: .normal)
            
            
        } else {
            rightButton.setImage(UIImage(named: "hide-password")?.withTintColor(UIColor.black) , for: .normal)
           
        }
    }
    
}

