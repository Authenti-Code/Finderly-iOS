//
//  VerificationOtpVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 03/01/22.
//

import UIKit
import SVProgressHUD

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
    //MARK:-> VAriables
    var email = String()
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
 
        //MARK:-> view shadow
        self.otpVw1.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.otpVw2.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.otpVw3.applyShadowWithCornerRadius(color:appcolor.backgroundShadow  , opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.otpVw4.applyShadowWithCornerRadius(color:appcolor.backgroundShadow  , opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
    }
    //MARK:--> Button Actions
    @IBAction func btnBackAction(_ sender: Any){
        self.pop()
    }
    @IBAction func resendOtpBtnAcn(_ sender: Any) {
        resendForgotOtpApi()
    }
    @IBAction func verifyBtnAcn(_ sender: Any){
        if otpbox1.text?.trimmed().isEmpty == false && otpbox2.text?.trimmed().isEmpty == false && otpbox3.text?.trimmed().isEmpty == false && otpbox4.text?.trimmed().isEmpty == false{
            verifyForgotOtp(otp: "\(otpbox1.text ?? "")\(otpbox2.text ?? "")\(otpbox3.text ?? "")\(otpbox4.text ?? "")"){
                let vc = storyboardMain.instantiateViewController(withIdentifier: "CreateNewPasswordVCID") as! CreateNewPasswordVC
                vc.email = self.email
                self.navigationController?.pushViewController(vc,animated: true)
            }
        }else{
            Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.validOtp)
        }
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
extension VerificationOtpVC{
    func verifyForgotOtp(otp: String, completion:@escaping() -> Void){
        SVProgressHUD.show()
        var param = [String: String]()
        var verifyOtpUrl = ""
            verifyOtpUrl = "\(Apis.KServerUrl)\(Apis.kForgotVerifyOtp)"
            param = ["otp":"\(otp)",
                     "email":"\(email)"]
            print("Param:\(param)")
        let kURL = verifyOtpUrl.encodedURLString()
        print("kURL:->\(kURL)")
        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    SVProgressHUD.dismiss()
                    completion()
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
extension VerificationOtpVC{
    func resendForgotOtpApi(){
        SVProgressHUD.show()
        var param = [String: String]()
        var verifyOtpUrl = ""
            verifyOtpUrl = "\(Apis.KServerUrl)\(Apis.kForgortPassword)"
            param = ["email":"\(email)"]
            print("Param:\(param)")
        let kURL = verifyOtpUrl.encodedURLString()
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
