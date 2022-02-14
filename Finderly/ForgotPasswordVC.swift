//
//  ForgotPasswordVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 03/01/22.
//

import UIKit
import SVProgressHUD

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var oMailView: UIView!
    @IBOutlet weak var oMailTextField: UITextField!
    @IBOutlet weak var oTickImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()
        
    }
    func loadItem(){
        self.oMailView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
    @IBAction func submitBtnAcn(_ sender: Any) {
        if oMailTextField.text?.isEmpty == true{
            Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.email)
        } else{
            forgotPasswordApi {
                self.sendOtp()
                return
            }
    }

}
    func sendOtp(){
        let vc = storyboardMain.instantiateViewController(withIdentifier: "VerificationOtpVCID") as! VerificationOtpVC
        vc.email = oMailTextField.text!
        navigationController?.pushViewController(vc,animated: true)
    }
}
extension ForgotPasswordVC{
    func forgotPasswordApi(completion:@escaping() -> Void)  {
        SVProgressHUD.show()
        let forgot = "\(Apis.KServerUrl)\(Apis.kForgortPassword)"
        let kURL = forgot.encodedURLString()
        let param = [
            "email": oMailTextField.text ?? ""
        ] as [String:String]
        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { [self] (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    if let dataDict = JSON["data"] as? NSDictionary {
                        print("Dict:",dataDict)
                    }
                    completion()
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
