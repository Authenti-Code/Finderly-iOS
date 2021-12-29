//
//  Extensions.swift
//  Findirly
//
//  Created by D R Thakur on 24/12/21.
//

import Foundation
import UIKit
//MARK-> Validations
public extension String
{
    /*func toJSON() -> JSON
     {
     //        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return JSON() }; return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
     
     }*/
    
    /*
     
     public static String extractYTId(String ytUrl) {
     String vId = null;
     Pattern pattern = Pattern.compile(
     "^https?://.*(?:youtu.be/|v/|u/\\w/|embed/|watch?v=)([^#&?]*).*$",
     Pattern.CASE_INSENSITIVE);
     Matcher matcher = pattern.matcher(ytUrl);
     if (matcher.matches()){
     vId = matcher.group(1);
     }
     return vId;
     }
     */
    var isBlank : Bool {
        return (self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    var removingWhitespacesAndNewlines: String {
        return components(separatedBy: .whitespacesAndNewlines).joined()
    }
    
    var length: Int { return self.count }
    
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    func isEmail() throws -> Bool {
        let regex = try NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9-]+\\.[A-Z]{2,4}$", options: [.caseInsensitive])
        return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
    }
    
    func isAlphaSpace() throws -> Bool {
        let regex = try NSRegularExpression(pattern: "^[A-Za-z ]*$", options: [])
        return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    
    //    func isNumeric() throws -> Bool {
    //        let regex = try NSRegularExpression(pattern: "^[0-9]*$", options: [])
    //
    //        return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    //    }
    
    func isRegistrationNumber() throws -> Bool {
        let regex = try NSRegularExpression(pattern: "^[A-Za-z0-9 ]*$", options: [])
        
        return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    
}

//View shadow
enum AIEdge:Int {
    case
    Top,
    Left,
    Bottom,
    Right,
    Top_Left,
    Top_Right,
    Bottom_Left,
    Bottom_Right,
    All,
    None
}
extension UIView {
    func applyShadowWithCornerRadius(color:UIColor, opacity:Float, radius: CGFloat, edge:AIEdge, shadowSpace:CGFloat, cornerRadius: CGFloat)    {
        
        var sizeOffset:CGSize = CGSize.zero
        
        switch edge {
        case .Top:
            sizeOffset = CGSize(width: 0, height: -shadowSpace)
        case .Left:
            sizeOffset = CGSize(width: -shadowSpace, height: 0)
        case .Bottom:
            sizeOffset = CGSize(width: 0, height: shadowSpace)
        case .Right:
            sizeOffset = CGSize(width: shadowSpace, height: 0)
            
            
        case .Top_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace)
        case .Top_Right:
            sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace)
        case .Bottom_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace)
        case .Bottom_Right:
            sizeOffset = CGSize(width: shadowSpace, height: shadowSpace)
        case .All:
            sizeOffset = CGSize(width: 0, height: 0)
        case .None:
            sizeOffset = CGSize.zero
        }
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = sizeOffset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
    }
}

@available(iOS 13.0, *)
extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = (self.frame.size.width) / 2;
        self.clipsToBounds = true
        self.layer.borderWidth = 3.0
        //self.layer.borderColor = UIColor.white.cgColor
        if #available(iOS 13.0, *) {
            self.layer.borderColor = CGColor(red: 204/255, green: 228/255, blue: 248/255, alpha: 1)
        } else {
            // Fallback on earlier versions
        }
    }
}

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}
