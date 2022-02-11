//
//  SignUpVM.swift
//  Prestmit
//
//  Created by Desh Raj Thakur on 31/05/21.
//

import Foundation
import UIKit
import SVProgressHUD

class OtpVerifyVM {
    var controllerForgotSelected = Bool()
    var mailString: String?
    //MARK:- Hit OTP Api Method
    func hitSendOtpVerifyMethod(otp: String, completion:@escaping() -> Void) {
        SVProgressHUD.show()
        var param = [String: String]()
        var verifyOtpUrl = ""
        if controllerForgotSelected == true {
            verifyOtpUrl = "\(Apis.KServerUrl)\(Apis.kForgortPasswordOtp)"
            param = [
                "otp":  "\(otp)",
                "email":  "\(mailString ?? "")"
            ]
        } else{
            verifyOtpUrl = "\(Apis.KServerUrl)\(Apis.verifyOtp)"
            param = [
                "otp":  "\(otp)"
            ]
            print("Param:\(param)")
        }
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
    //MARK:-> Hit OTP Api Method
//    func hitReSendOtpMethod(completion:@escaping() -> Void) {
//        SVProgressHUD.show()
//        let verifyOtp = "\(Apis.KServerUrl)\(Apis.kSendOtp)"
//        let kURL = verifyOtp.encodedURLString()
//        let param = [
//            "email": "\(mailString ?? "")"
//        ] as [String: String]
//        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
//            if isSuccess {
//                if JSON["success"] as? String == "true"{
//                    completion()
//                    SVProgressHUD.dismiss()
//                    Proxy.shared.displayStatusCodeAlert(constants.otpVerify)
//                } else{
//                    SVProgressHUD.dismiss()
//                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
//                }
//            } else {
//                SVProgressHUD.dismiss()
//                Proxy.shared.displayStatusCodeAlert(message)
//            }
//        }
//    }
}
