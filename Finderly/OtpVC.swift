//
//  OTPVC.swift
//  Findirly
//
//  Created by D R Thakur on 24/12/21.
//

import UIKit
import SVProgressHUD

class OtpVC: UIViewController {
    //MARK:-> IBOutlets
    @IBOutlet weak var otpbox1: UITextField!
    @IBOutlet weak var otpbox2: UITextField!
    @IBOutlet weak var otpbox3: UITextField!
    @IBOutlet weak var otpbox4: UITextField!
    @IBOutlet weak var otpVw1: UIView!
    @IBOutlet weak var otpVw2: UIView!
    @IBOutlet weak var otpVw3: UIView!
    @IBOutlet weak var otpVw4: UIView!
    //MARK:-> Variables
    let userModelObj = UserDataModel()
    var otpVerifyVMObj = OtpVerifyVM()
    var sentOtp = String()
    //MARK:-> View's Life Cycle
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
        
        sentOtp = "\(userModelObj.otp ?? 0)"
        print("Sent Otp:->",sentOtp)
 
        //MARK:-> view shadow
        self.otpVw1.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.otpVw2.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.otpVw3.applyShadowWithCornerRadius(color:appcolor.backgroundShadow  , opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.otpVw4.applyShadowWithCornerRadius(color:appcolor.backgroundShadow  , opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
    }
    //MARK:--> Button Actions
    @IBAction func btnBackAction(_ sender: Any){
        Proxy.shared.popNaviagtion(isAnimate: true, currentViewController: self)
    }
    @IBAction func resendOtpBtnAcn(_ sender: Any) {
        resendOtpApi()
    }
    @IBAction func btnContinueAction(_ sender: Any){
        if otpbox1.text?.trimmed().isEmpty == false && otpbox2.text?.trimmed().isEmpty == false && otpbox3.text?.trimmed().isEmpty == false && otpbox4.text?.trimmed().isEmpty == false{
            otpVerifyVMObj.hitSendOtpVerifyMethod(otp: "\(otpbox1.text ?? "")\(otpbox2.text ?? "")\(otpbox3.text ?? "")\(otpbox4.text ?? "")"){
                if self.otpVerifyVMObj.controllerForgotSelected == true{
//                    let nav = storyboardMain.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
//                    nav.mailStr = self.otpVerifyVMObj.mailString
//                    self.navigationController?.pushViewController(nav, animated: true)
                } else{
                    Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "UploadProfileVC", isAnimate: true, currentViewController: self)
                }
            }
           
        }else{
            Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.validOtp)
        }
    }
}
//MARK:-> TextField Delegate
extension OtpVC: UITextFieldDelegate{
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
//MARK:-> API Method for Verify Otp Screen
extension OtpVC{
    func resendOtpApi(){
        SVProgressHUD.show()
        var param = [String: String]()
        var updatePass = ""
        updatePass = "\(Apis.KServerUrl)\(Apis.kResendOtp)"
        param = ["":""]
            print("Param:\(param)")
        let kURL = updatePass.encodedURLString()
        print("kURL:->\(kURL)")
        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    SVProgressHUD.dismiss()
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                } else{
                    SVProgressHUD.dismiss()
                    Proxy.shared.displayStatusCodeAlert(JSON["errorMessage"] as? String ?? "")
                }
            } else {
                SVProgressHUD.dismiss()
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}
