//
//  Proxy.swift
//  Findirly
//
//  Created by D R Thakur on 24/12/21.
//

import Foundation
import UIKit
class Proxy {
    static var shared: Proxy {
        return Proxy()
    }
    fileprivate init(){}
    
    //MARK:- Check Valid Email Method
    func isValidEmail(_ testStr:String) -> Bool  {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return (testStr.range(of: emailRegEx, options:.regularExpression) != nil)
    }
    //MARK:- Check Valid Password Method
    func isValidPassword(_ testStr:String) -> Bool {
        let capitalLetterRegEx  = ".*[A-Za-z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: testStr)
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: testStr)
        
        let specialCharacterRegEx  = ".*[!&^%$#@()*/]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        let specialresult = texttest2.evaluate(with: testStr)
        
        let eightRegEx  = ".{8,}"
        let texttest3 = NSPredicate(format:"SELF MATCHES %@", eightRegEx)
        let eightresult = texttest3.evaluate(with: testStr)
        return  specialresult && capitalresult && numberresult && eightresult
    }
    //MARK:- Check Valid Name Method
    func isValidInput(_ Input:String) -> Bool {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")
        if Input.rangeOfCharacter(from: characterset.inverted) != nil {
            return false
        } else {
            return true
        }
    }
    //MARK:--> Set Attribute String
    //    func attributeSetString(textString: String, fontString: String) -> NSAttributedString{
    //        let myMutableString = NSMutableAttributedString(string: textString , attributes: [NSAttributedString.Key.font:UIFont(name: FontString.SFProDisplay, size: 20.0)!])
    //        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location:0,length: myMutableString.length))
    //        return myMutableString
    //    }
    
    //MARK:--> TIME ZONE
    func getCurrentTimeZone() -> String{
        return TimeZone.current.identifier
    }
    //MARK:-> Dates Conversion
    let gregorian_calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)! as Calendar
    let server_dt_format = "yyyyMMddHHmmss"
    let serverDateFormat = "yyyy-MM-dd"
    // let serverForgotDateFormat = "yyyyMMdd HHmmss"
    func DateToString(Formatter:String, date:Date) -> String
    {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = Formatter
        dateformatter.locale = Locale(identifier: "en_US")
        dateformatter.calendar = gregorian_calendar
        let convertedString = dateformatter.string(from: date)
        return convertedString
    }
    func StringToConvertedStringDate(strDate:String, strDateFormat:String, strRequiredFormat:String) -> String{
        let dateformatter = DateFormatter()
        dateformatter.calendar = gregorian_calendar
        dateformatter.locale = Locale(identifier: "en_US")
        dateformatter.dateFormat = strDateFormat
        guard let convertedDate = dateformatter.date(from: strDate) else {
            return ""
        }
        dateformatter.dateFormat = strRequiredFormat
        let convertedString = dateformatter.string(from: convertedDate)
        return convertedString
    }
    func StringToDate(Formatter : String,strDate : String) -> Date{
        let dateformatter = DateFormatter()
        dateformatter.calendar = gregorian_calendar
        dateformatter.locale = Locale(identifier: "en_US")
        dateformatter.dateFormat = Formatter
        guard let convertedDate = dateformatter.date(from: strDate) else {
            let str = dateformatter.string(from: Date())
            return dateformatter.date(from: str)!
        }
        return convertedDate
    }
    //MARK:- Display Toast
    func displayStatusCodeAlert(_ userMessage: String) {
        let alert = UIAlertController(title: AppName, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    //MARK:--> NAVIGATION
    func pushNaviagtion(stryboard:UIStoryboard, identifier:String, isAnimate:Bool , currentViewController: UIViewController) {
        let pushControllerObj = stryboard.instantiateViewController(withIdentifier: identifier)
        pushControllerObj.hidesBottomBarWhenPushed = true
        currentViewController.navigationController?.pushViewController(pushControllerObj, animated: isAnimate)
    }
    func pushNaviagtionHideBottomBar(stryboard:UIStoryboard, identifier:String, isAnimate:Bool , currentViewController: UIViewController) {
        let pushControllerObj = stryboard.instantiateViewController(withIdentifier: identifier)
        pushControllerObj.hidesBottomBarWhenPushed = true
        currentViewController.navigationController?.pushViewController(pushControllerObj, animated: isAnimate)
    }
    func popNaviagtion(isAnimate:Bool , currentViewController: UIViewController) {
        currentViewController.navigationController?.popViewController(animated: isAnimate)
    }
    //MARK:- Open Setting Of App
    //    func openSettingApp() {
    //        let settingAlert = UIAlertController(title: AppAlerts.titleValue.connectionProblem, message: AppAlerts.titleValue.checkInternet, preferredStyle: UIAlertController.Style.alert)
    //        let okAction = UIAlertAction(title: AppAlerts.titleValue.cancel, style: UIAlertAction.Style.default, handler: nil)
    //        settingAlert.addAction(okAction)
    //        let openSetting = UIAlertAction(title: AppAlerts.titleValue.setting, style:UIAlertAction.Style.default, handler:{ (action: UIAlertAction!) in
    //            let url:URL = URL(string: UIApplication.openSettingsURLString)!
    //            if #available(iOS 10, *) {
    //                UIApplication.shared.open(url, options: [:], completionHandler: {
    //                                            (success) in })
    //            } else {
    //                guard UIApplication.shared.openURL(url) else {
    //                    Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.pleaseReviewyournetworksettings)
    //                    return
    //                }
    //            }
    //        })
    //        settingAlert.addAction(openSetting)
    //        UIApplication.shared.keyWindow?.rootViewController?.present(settingAlert, animated: true, completion: nil)
    //    }
}
