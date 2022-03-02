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
    var validator:Validators!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewData()
    }
    //MARK:-> Load View
    func loadViewData(){
        //MARK:-> view shadow
        self.validator = Validators()
        self.oUsernameVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oMailVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oPswrdVw.applyShadowWithCornerRadius(color:appcolor.backgroundShadow  , opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oconfirmPswrdVw.applyShadowWithCornerRadius(color:appcolor.backgroundShadow  , opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oPhoneVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        oimgVwPswrd.image = Images.hidePswrd
        oimgVwConfrmPsrd.image = Images.hidePswrd
        otxtfldPswrd.isSecureTextEntry = true
        otxtfldCnfrmPswrd.isSecureTextEntry = true
    }
    //MARK:--> Button Actions
    @IBAction func btnSignInAction(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSignUpAction(_ sender: Any){
        guard validator.validators(TF1: self.otxtfldUsrName,fieldName: "user name") == false ||
                validator.validators(TF1: self.otxtfldPhone,fieldName: "phone number") == false || validator.validatorEmail(TF1: self.otxtfldMail,fieldName: "email") == false ||  validator.validators(TF1: self.otxtfldPswrd,fieldName: "password") == false || validator.validators(TF1: self.otxtfldCnfrmPswrd,fieldName: "confirm password") == false || validator.validatorConfromPassword(TF1: self.otxtfldPswrd, TF2: self.otxtfldCnfrmPswrd,fieldName: "correct password") == false
        else{
            if self.otxtfldPswrd.text?.count ?? 0 < 8{
                Proxy.shared.displayStatusCodeAlert(constants.password)
                return
            }else {
                signupApi {
                    Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "OtpVC", isAnimate: true, currentViewController: self)
                }
            }
            return
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
//MARK:-> Singup Api Method Handling
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
