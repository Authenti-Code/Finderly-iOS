//
//  Validators.swift
//  SearchApp
//
//  Created by dEEEP on 07/03/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//

import Foundation
import UIKit
import BRYXBanner

struct validatorConstants{
    static let errorMsg = "Please make sure to enter some input."
    static let customMsg = "Please enter "
    static let emailMsg =  "Please enter valid email Address."
    static let phoneMsg = "Please enter valid phone number."
    static let passwordConfromMsg = "Make sure you confirm password is same"
    static let errorMsgValidname = "Please enter a valid name."
}

class Validators: NSObject {
    
    //MARK: Validation on any Empty TextField
    func validators(TF1:UITextField,errorMsg:String = validatorConstants.customMsg,fieldName:String = "") -> Bool {
        var error = validatorConstants.customMsg
        if fieldName.count > 0 {
            error = validatorConstants.customMsg + fieldName
        }
        if  TF1.text?.isEmpty == true{
            // kAppDelegate.showNotification(text: error)
            Proxy.shared.displayStatusCodeAlert(error)
            
            return false
        }
        return true
    }
    
    //MARK: Validation on any Email TextField
    func validatorEmail(TF1:UITextField,errorMsg:String = validatorConstants.customMsg ,errorMsgEmail:String = validatorConstants.emailMsg,fieldName:String = "" ) -> Bool {
        var error = validatorConstants.customMsg
        if fieldName.count > 0 {
            error = validatorConstants.customMsg + fieldName
        }
        
        if  TF1.text?.isEmpty == true{
            //kAppDelegate.showNotification(text: error)
            Proxy.shared.displayStatusCodeAlert(error)
            return false
        }
        if  TF1.text?.isValidEmail == false{
            //   kAppDelegate.showNotification(text: errorMsgEmail)
            Proxy.shared.displayStatusCodeAlert(errorMsgEmail)
            return false
        }
        return true
    }
    
    //MARK: Validation on any PhoneNumber TextField
    func validatorPhoneNumber(TF1:UITextField,errorMsg:String = validatorConstants.errorMsg ,errorMsgPhone:String = validatorConstants.phoneMsg,fieldName:String = "Phone Number") -> Bool {
        var error = validatorConstants.errorMsg
        if fieldName.count > 0 {
            error = validatorConstants.customMsg + fieldName
        }
        
        if  TF1.text?.isEmpty == true{
            // kAppDelegate.showNotification(text: error)
            NotificationAlert().NotificationAlert(titles: error)
            return false
        }
        if  TF1.text?.isValidPhoneNumber == false{
            NotificationAlert().NotificationAlert(titles: errorMsgPhone)
            //  kAppDelegate.showNotification(text: errorMsgPhone)
            return false
        }
        return true
    }
    
    //MARK: Validation on any confromPassword TextField
    func validatorConfromPassword(TF1:UITextField,TF2:UITextField,errorMsg:String = validatorConstants.errorMsg,errorMsgPassword:String = validatorConstants.passwordConfromMsg,fieldName:String = "Password") -> Bool {
        
        var error = validatorConstants.errorMsg
        if fieldName.count > 0 {
            error = validatorConstants.customMsg + fieldName
        }
        
        if  TF1.text?.isEmpty == true{
            //  kAppDelegate.showNotification(text: error)
            NotificationAlert().NotificationAlert(titles: error)
            
            return false
        }
        if  TF2.text?.isEmpty == true{
            //  kAppDelegate.showNotification(text: error)
            NotificationAlert().NotificationAlert(titles: error)
            return false
        }
        if TF1.text !=  TF2.text {
            //   kAppDelegate.showNotification(text: errorMsgPassword)
            NotificationAlert().NotificationAlert(titles: errorMsgPassword)
            return false
        }
        return true
    }
    //MARK: Validation on length of charcter on TextFieldDelegate Method
    func validateLength(TF1:UITextField,string:String,range:NSRange,fieldName:String = "",lengthLimit:Int = 30) -> Bool {
        var error = "Max Length for this field is \(lengthLimit)."
        if fieldName.count > 0 {
            error = "Max Length for " + fieldName +  "is \(lengthLimit)."
        }
        
        let currentCharacterCount = TF1.text?.count ?? 0
        let newLength = currentCharacterCount + string.count - range.length
        if newLength == 30{
           // kAppDelegate.showNotification(text: error)
        NotificationAlert().NotificationAlert(titles: error)
        }
        return newLength <= 30
        
    }
    //MARK:- MAX LENGTH
    func validateMaxLenght(TF1: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 5
        let currentString: NSString = TF1.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func validateUsername(str: String) -> Bool
    {
        do
        {
            let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z\\_]{3,15}$", options: .caseInsensitive)
            if regex.matches(in: str, options: [], range: NSMakeRange(0, str.count)).count > 0 {
                return true
                
            }else{
              NotificationAlert().NotificationAlert(titles: "Please enter a valid name.")
                // kAppDelegate.showNotification(text:"Please enter a valid name.")
            }
        }
        catch {
            print("error")
        }
        return false
    }
    
    
    
}
