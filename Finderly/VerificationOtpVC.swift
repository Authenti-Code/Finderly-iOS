//
//  VerificationOtpVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 03/01/22.
//

import UIKit

class VerificationOtpVC: UIViewController {

    //Add all outlet in your code.
    @IBOutlet weak var otpbox1: UITextField!
    @IBOutlet weak var otpbox2: UITextField!
    @IBOutlet weak var otpbox3: UITextField!
    @IBOutlet weak var otpbox4: UITextField!
    @IBOutlet weak var otpVw1: UIView!
    @IBOutlet weak var otpVw2: UIView!
    @IBOutlet weak var otpVw3: UIView!
    @IBOutlet weak var otpVw4: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        otpbox1?.delegate = self
        otpbox2?.delegate = self
        otpbox3?.delegate = self
        otpbox4?.delegate = self
        
        otpVw1.backgroundColor = appcolor.backgroundShadow
        otpVw2.backgroundColor = appcolor.backgroundShadow
        otpVw3.backgroundColor = appcolor.backgroundShadow
        otpVw4.backgroundColor = appcolor.backgroundShadow
 
        //view shadow
        self.otpVw1.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.otpVw2.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.otpVw3.applyShadowWithCornerRadius(color:appcolor.backgroundShadow  , opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.otpVw4.applyShadowWithCornerRadius(color:appcolor.backgroundShadow  , opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
    }
    //MARK:--> Button Actions
    @IBAction func btnBackAction(_ sender: Any){
        self.pop()
    }
    @IBAction func verifyBtnAcn(_ sender: Any){
        Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "CreateNewPasswordVCID", isAnimate: true, currentViewController: self)
    }
}
//TextField Delegate
extension VerificationOtpVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        // Range.length == 1 means,clicking backspace
        if (range.length == 0){
            if textField == otpbox1 {
                otpbox2?.becomeFirstResponder()
            }
            if textField == otpbox2 {
                otpbox3?.becomeFirstResponder()
            }
            if textField == otpbox3 {
                otpbox4?.becomeFirstResponder()
            }
            if textField == otpbox4 {
                otpbox4?.resignFirstResponder()
                let otp = "\((otpbox1?.text)!)\((otpbox2?.text)!)\((otpbox3?.text)!)\((otpbox4?.text)!)"
                print("otp:",otp)
            }
            textField.text? = string
            return false
        }else if (range.length == 1) {
            if textField == otpbox4 {
                otpbox3?.becomeFirstResponder()
            }
            if textField == otpbox3 {
                otpbox2?.becomeFirstResponder()
            }
            if textField == otpbox2 {
                otpbox1?.becomeFirstResponder()
            }
            if textField == otpbox1 {
                otpbox1?.resignFirstResponder()
            }
            textField.text? = ""
            return false
        }
        return true
    }
}
