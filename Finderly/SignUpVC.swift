//
//  SignUpVC.swift
//  Findirly
//
//  Created by D R Thakur on 22/12/21.
//

import UIKit
import SVProgressHUD

class SignUpVC: UIViewController {
    //MARK:--> IBOutlets
    @IBOutlet weak var oMailVw: UIView!
    @IBOutlet weak var oimgVwMail: UIImageView!
    @IBOutlet weak var oPhoneVw: UIView!
    @IBOutlet weak var oimgVwPhone: UIImageView!
    @IBOutlet weak var oUsernameVw: UIView!
    @IBOutlet weak var oimgVwUsrNm: UIImageView!
    @IBOutlet weak var oconfirmPswrdVw: UIView!
    @IBOutlet weak var oimgVwConfrmPsrd: UIImageView!
    @IBOutlet weak var oPswrdVw: UIView!
    @IBOutlet weak var oimgVwPswrd: UIImageView!
    
    @IBOutlet weak var otxtfldMail: UITextField!
    @IBOutlet weak var otxtfldUsrName: UITextField!
    @IBOutlet weak var otxtfldPhone: UITextField!
    @IBOutlet weak var otxtfldCnfrmPswrd: UITextField!
    @IBOutlet weak var otxtfldPswrd: UITextField!
    
    @IBOutlet weak var btnSignup: UIButton!
    var securedPswrd = true
    var securedCnfrmPswrd = true
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewData()
    }
    //MARK:-> Load View
    func loadViewData(){
        //view shadow
        self.oUsernameVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oMailVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oPswrdVw.applyShadowWithCornerRadius(color:appcolor.backgroundShadow  , opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oconfirmPswrdVw.applyShadowWithCornerRadius(color:appcolor.backgroundShadow  , opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oPhoneVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        //set default image
        oimgVwMail.image = Images.imgEmpty
        oimgVwUsrNm.image = Images.imgEmpty
        oimgVwPhone.image = Images.imgEmpty
        oimgVwPswrd.image = Images.hidePswrd
        oimgVwConfrmPsrd.image = Images.hidePswrd
        //delegate self
        otxtfldMail.delegate = self
        otxtfldUsrName.delegate = self
        otxtfldPhone.delegate = self
        otxtfldCnfrmPswrd.delegate = self
        otxtfldPswrd.delegate = self
        
        otxtfldPswrd.isSecureTextEntry = true
        otxtfldCnfrmPswrd.isSecureTextEntry = true
    }
    //MARK--> Button Actions
    @IBAction func btnSignInAction(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSignUpAction(_ sender: Any){
        signupApi {
            Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "OtpVC", isAnimate: true, currentViewController: self)
        }
        
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
    @IBAction func btnShowHideConfirmPswrdAction(_ sender: Any) {
        if securedCnfrmPswrd == true{
            securedCnfrmPswrd = false
            oimgVwConfrmPsrd.image = Images.showPswrd
            otxtfldCnfrmPswrd.isSecureTextEntry = false
        } else{
            securedCnfrmPswrd = true
            oimgVwConfrmPsrd.image = Images.hidePswrd
            otxtfldCnfrmPswrd.isSecureTextEntry = true
        }
    }
}
//UITextFiled Delegate
extension SignUpVC: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == otxtfldUsrName && !Proxy.shared.isValidInput(otxtfldUsrName.text!){
            if otxtfldUsrName.text?.isBlank == true{
                oimgVwUsrNm.image = Images.uncheck
                Proxy.shared.displayStatusCodeAlert(AppAlert.usrname)
            }else{
                oimgVwUsrNm.image = Images.check
            }
        }else if textField == otxtfldPhone{
            if otxtfldPhone.text?.isBlank == true{
                oimgVwPhone.image = Images.uncheck
                Proxy.shared.displayStatusCodeAlert(AppAlert.phone)
            }else{
                oimgVwPhone.image = Images.check
            }
        }else if textField == otxtfldMail{
            if !Proxy.shared.isValidEmail(otxtfldMail.text!) && otxtfldMail.text?.isBlank == true{
                oimgVwMail.image = Images.uncheck
                Proxy.shared.displayStatusCodeAlert(AppAlert.mail)
            }else{
                oimgVwMail.image = Images.check
            }
        } else if textField == otxtfldPswrd{
            if otxtfldPswrd.text?.isBlank == true{
                oimgVwPswrd.image = Images.uncheck
                Proxy.shared.displayStatusCodeAlert(AppAlert.passwrd)
            }else{
                oimgVwPswrd.image = Images.check
            }
        } else if textField == otxtfldCnfrmPswrd{
            if otxtfldCnfrmPswrd.text?.isBlank == true && otxtfldPswrd.text != otxtfldCnfrmPswrd.text{
                oimgVwConfrmPsrd.image = Images.uncheck
                Proxy.shared.displayStatusCodeAlert(AppAlert.confirmPswrd)
            }else{
                oimgVwConfrmPsrd.image = Images.check
            }
        }
    }
}
extension SignUpVC{
    func signupApi(completion:@escaping() -> Void){
        SVProgressHUD.show()
        let signupDetail = "\(Apis.KServerUrl)\(Apis.kRegister)"
        let kUrl = signupDetail.encodedURLString()
        let param = ["user_name": otxtfldUsrName.text ?? "","country_code": "789798","mobile_number": otxtfldPhone.text ?? "","email": otxtfldMail.text ?? "","password": otxtfldPswrd.text ?? "","c_password": otxtfldCnfrmPswrd.text ?? "","device_id": AppInfo.DeviceId,"device_token":"firebasetoken","device_type":"IOS"]
        WebProxy.shared.postData(kUrl, params: param, showIndicator: true, methodType: .post) {(JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    if let dataDict = JSON["data"] as? NSDictionary{
                        print("DataDict:",dataDict)
                        let userDataObj = UserDataModel()
                        userDataObj.fromSignUp = true
                        userDataObj.userInfo(dataDict: dataDict)
                        SVProgressHUD.dismiss()
                    }
                    completion()
                    SVProgressHUD.dismiss()
                    Proxy.shared.displayStatusCodeAlert(AppAlert.otpVerify)
                }else{
                    SVProgressHUD.dismiss()
                    Proxy.shared.displayStatusCodeAlert(AppAlert.emailTaken)
                }
            }else{
                SVProgressHUD.dismiss()
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}
