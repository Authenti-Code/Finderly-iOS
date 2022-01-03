//
//  ViewController.swift
//  Findirly
//
//  Created by D R Thakur on 22/12/21.
//

import UIKit

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
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewData()
    }
    //MARK:-> Load View
    func loadViewData(){
        //view shadow
        self.oMailVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oPasswordVw.applyShadowWithCornerRadius(color:appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oAppleVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oGoogleVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        //set default image
        oimgVwPswrd.image = Images.hidePswrd
        oimgVwMail.image = Images.imgEmpty
        otxtfldPswrd.isSecureTextEntry = true
        
        otxtfldMail.delegate = self
    }
    //MARK:--> Button Actions
    @IBAction func btnLoginAction(_ sender: Any) {
        
    }
    @IBAction func btnGoogleInAction(_ sender: Any){
    }
    @IBAction func btnAppleInAction(_ sender: Any){
    }
    @IBAction func forgotPasswordBtnAcn(_ sender: Any) {
        let nav = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVCID")
        self.navigationController?.pushViewController(nav!, animated: true)
    }
    //MARK--> Button Actions
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
//UITextFiled Delegate
extension LoginVC: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == otxtfldMail{
            if !Proxy.shared.isValidEmail(otxtfldMail.text!) && otxtfldMail.text?.isBlank == true{
                oimgVwMail.image = Images.uncheck
                Proxy.shared.displayStatusCodeAlert(AppAlert.mail)
            } else{
                oimgVwMail.image = Images.check
            }
        }
    }
}

