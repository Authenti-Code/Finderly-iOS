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
extension UIViewController{
    func pop(){
        navigationController?.popViewController(animated: true)
    }
}
extension UINavigationController {
    func backToViewController(viewController: Swift.AnyClass) {
        for element in viewControllers as Array {
            if element.isKind(of: viewController) {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}
extension UIImage {
    func upOrientationImage() -> UIImage? {
        switch imageOrientation {
        case .up:
            return self
        default:
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            draw(in: CGRect(origin: .zero, size: size))
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return result
        }
    }
}
extension UIView {
    //ROUNDED CORNER TOP VIEW
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.clipsToBounds = true
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
public extension String
{
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    var youtubeID: String?
    {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, options: [], range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    //var length: Int { return self.count }
    
    func toURL() -> URL? {
        return URL(string: self)
    }
    
    func encodeQueryString() -> String
    {
        return self.replacingOccurrences(of: "'", with: "''", options:.regularExpression)
    }
    func encodedURLString() -> String
    {
        let escapedString = self.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        return escapedString ?? self
    }
    func encodedNameString() -> String
    {
        
        /*
         
         String newUrl = finalUrl.replaceAll(" ", "%20");
         newUrl = newUrl.replaceAll("\\r", "");
         newUrl = newUrl.replaceAll("\\t", "");
         newUrl = newUrl.replaceAll("\\n\\n", "%20");
         newUrl = newUrl.replaceAll("\\n", "%20");
         newUrl = newUrl.replaceAll("\\|", "%7C");
         newUrl = newUrl.replaceAll("\\+", "%2B");
         
         newUrl = newUrl.replaceAll("\\#", "%23");
         
         */
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "@#$*^&+= ").inverted)
        
        let escapedString = self.addingPercentEncoding(withAllowedCharacters:allowedCharacterSet)
        
        return escapedString ?? self
    }
    
    func encodeString() -> String
    {
        var str = self
        str = str.replacingOccurrences(of: " ", with: "%20")
        str = str.replacingOccurrences(of: "\\r", with: "")
        str = str.replacingOccurrences(of: "\\t", with: "")
        str = str.replacingOccurrences(of: "\\n\\n", with: "%20")
        str = str.replacingOccurrences(of: "\\n", with: "%20")
        str = str.replacingOccurrences(of: "\\|", with: "%7C")
        str = str.replacingOccurrences(of: "\\+", with: "%2B")
        str = str.replacingOccurrences(of: "\\#", with: "%23")
        
        return str
    }
    
    
    func hexStringToUIColor () -> UIColor {
        let hex = self
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
extension String {

    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isNumeric : Bool {
        return NumberFormatter().number(from: self) != nil
    }
    
    var showCommaPrice : String {
        if self != "" {
            let priceStr = String(format: "%.2f", Double(self)!)
            return priceStr.replacingOccurrences(of: ".", with: ",")
        } else {
            return ""
        }
    }
    
    var isNumericOfPrice: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ",", "."]
        return Set(self).isSubset(of: nums)
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,value: 1,range: NSRange(location: 0, length: attributeString.length))
        return attributeString
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
    
    var isValidName: Bool {
        let RegEx = "^[a-zA-Z ]*$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: self)
    }
}
