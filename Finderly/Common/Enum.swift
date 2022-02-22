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
enum constantsVaribales{
    static let homeTVArry = ["Businessess1","Businessess2","Businessess3"]
    static let  catoImageArry = ["Rental","Resturents","Schools","Bars","Salons","Barbars","Shoes Store","GasStation","Automotives","Health"]
    static let catoHeadingArry = ["Rentals","Resturents","Schools","Bars","Salons","Barbers","Shoe Stores","Gas Stations","Automotives","Health Care"]
    static let profileLabelAry = ["Notification","About us","Contact us","Privacy policy"]
    static let profileImgAry = ["notification-icon","about-icon","phone-icon","privacy-icon"]
    static let businessDetailLablAry = ["Braids","Weave","Natural Haircoloring"]
    static let specializationLabelAry = ["Braids","Weave","Natural Haircoloring","Lace Fronts","Weddings","Cutting","Wigs","Crochet","Locs","Extensions"]
}
enum constants{
    static let gallery = "Choose For Gallery"
    static let camera = "Take Photo"
    static let gallerEdit = "Edit"
    static let camContinue = "Continue"
    static let userLibrary = "Choose From Library"
    static let userCamera = "Take A Photo"
    static let password = "Password should be minimum of 8 character!"
}
