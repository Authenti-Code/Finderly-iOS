//
//  Enum.swift
//  Findirly
//
//  Created by D R Thakur on 22/12/21.
//

import Foundation
import UIKit

//button corner radius
@IBDesignable extension UIButton {
    
    @IBInspectable override var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

enum Images{
    static let imgEmpty = UIImage(named:"")
    static let showPswrd = UIImage(named: "eyeActive")
    static let hidePswrd = UIImage(named: "eye-hide")
    static let check = UIImage(named: "checkMail")
    static let uncheck = UIImage(named: "cut")
}
