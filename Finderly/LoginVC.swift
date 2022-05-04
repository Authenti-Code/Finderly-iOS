//
//  ViewController.swift
//  Findirly
//
//  Created by D R Thakur on 22/12/21.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController {
    //MARK:--> IBOutlets
    @IBOutlet weak var oMailVw: UIView!
    @IBOutlet weak var oPasswordVw: UIView!
    @IBOutlet weak var otxtfldMail: UITextField!
    @IBOutlet weak var otxtfldPswrd: UITextField!
    @IBOutlet weak var oimgVwMail: UIImageView!
    @IBOutlet weak var oimgVwPswrd: UIImageView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var oGoogleVw: UIView!
    @IBOutlet weak var oAppleVw: UIView!
    var securedPswrd = true
    //MARK:-> View's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    //MARK:-> Load View
    func loadViewData(){
        //MARK:-> View Shadow
        self.oMailVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oPasswordVw.applyShadowWithCornerRadius(color:appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oAppleVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oGoogleVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        //MARK:-> Set Default Image
        oimgVwPswrd.image = Images.hidePswrd
        //oimgVwMail.image = Images.imgEmpty
        otxtfldPswrd.isSecureTextEntry = true
        //otxtfldMail.delegate = self
    }
    //MARK:--> Button Actions
    @IBAction func btnLoginAction(_ sender: Any) {
        if otxtfldMail.text?.isEmpty == true{
            Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.email)
        } else if otxtfldPswrd.text?.isEmpty == true{
            Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.password)
        } else{
            loginApi()
        }
        
    }
    @IBAction func btnGoogleInAction(_ sender: Any){
    }
    @IBAction func btnAppleInAction(_ sender: Any){
    }
    @IBAction func forgotPasswordBtnAcn(_ sender: Any) {
        let nav = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVCID")
        self.navigationController?.pushViewController(nav!, animated: true)
    }
    @IBAction func btnSignUpAction(_ sender: Any){
        let nav = storyboard?.instantiateViewController(withIdentifier: "SignUpVC")
        self.navigationController?.pushViewController(nav!, animated: true)
    }
    @IBAction func btnShowHidePswrdAction(_ sender: Any) {
        if securedPswrd == true{
            securedPswrd = false
            oimgVwPswrd.image = Images.showPswrd
            otxtfldPswrd.isSecureTextEntry = false
        } else{
            securedPswrd = true
            oimgVwPswrd.image = Images.hidePswrd
            otxtfldPswrd.isSecureTextEntry = true
        }
    }
}
//MARK:-> UITextFiled Delegate
//extension LoginVC: UITextFieldDelegate{
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == otxtfldMail{
//            if !Proxy.shared.isValidEmail(otxtfldMail.text!) && otxtfldMail.text?.isBlank == true{
//                //oimgVwMail.image = Images.uncheck
//                Proxy.shared.displayStatusCodeAlert(AppAlert.mail)
//            } else{
//                //oimgVwMail.image = Images.check
//            }
//        }
//    }
//}
extension LoginVC{
    func loginApi(){
        let loginDetal = "\(Apis.KServerUrl)\(Apis.kLogin)"
        let kURL = loginDetal.encodedURLString()
        let param = [
            "email": otxtfldMail.text ?? "",
            "password": otxtfldPswrd.text ?? "",
            "device_id": AppInfo.DeviceId,
            "device_token": "firebaseToken",
            "device_type":  "IOS"
        ] as [String:String]
        SVProgressHUD.show()
        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) {
            [self] (JSON, isSuccess, message) in
            if isSuccess {
                SVProgressHUD.dismiss()
                if JSON["success"] as? String == "true"{
                    if let dataDict = JSON["data"] as? NSDictionary {
                        accessToken = dataDict["token"] as? String ?? ""
                        let userDataObj = UserDataModel()
                        userDataObj.userInfo(dataDict: dataDict)
                        print("DataDict:",dataDict)
                        let signUpSteps = (dataDict["signup_step"] as? String)!
                        if signUpSteps == "1"{
                            Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "OtpVC", isAnimate: true, currentViewController: self)
                        }else if signUpSteps == "2"{
                            Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "UploadProfileVC", isAnimate: true, currentViewController: self)
                        }else if signUpSteps == "3"{
                            Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "CustomTabBarID", isAnimate: true, currentViewController: self)
                        }
                    }
                }else{
                    Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.loginFailed)
                }
            }
        }
    }
}
