//
//  Extensions.swift
//  CommanderContracts-iOS
//
//  Created by JOEL CRAWFORD on 10/18/21.
//


import UIKit

extension UIView{
    
    public var width: CGFloat{
        return frame.size.width
    }
    
    public var height: CGFloat{
           return frame.size.height
    }
    
    public var top: CGFloat{
              return frame.origin.y
       }
    
    public var bottom: CGFloat{
        return frame.origin.y +  frame.size.height
       }
    
    public var left: CGFloat{
              return frame.origin.x
       }
    
    public var right: CGFloat{
              return frame.origin.x + frame.size.width
       }
    
}

extension String {
      func safeDatabaseKey() -> String {
        return  self.replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_")
         //return  self.replacingOccurrences(of: ".", with: "_")
    }
    
 
    
    
}



extension UIFont {
    var bold: UIFont {
        return with(.traitBold)
    }

    var italic: UIFont {
        return with(.traitItalic)
    }

    var boldItalic: UIFont {
        return with([.traitBold, .traitItalic])
    }



    func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits).union(self.fontDescriptor.symbolicTraits)) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }

    func without(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(self.fontDescriptor.symbolicTraits.subtracting(UIFontDescriptor.SymbolicTraits(traits))) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}



extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}


