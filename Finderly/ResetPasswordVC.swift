//
//  ResetPasswordVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 10/05/22.
//

import UIKit

class ResetPasswordVC: UIViewController, PasswordSuccessProtocol {
    func removeRasswordSuccessObjPop(Address: String) {
         navigationController?.popToRootViewController(animated: false)
    }
    @IBOutlet weak var oldPasswordVw: UIView!
    @IBOutlet weak var newPasswordVw: UIView!
    @IBOutlet weak var confirmPasswordVw: UIView!
    @IBOutlet weak var oldPasswordEyeImg: UIImageView!
    @IBOutlet weak var newPasswordEyeImg: UIImageView!
    @IBOutlet weak var confirmPasswordEyeImg: UIImageView!
    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmNewPasswordTF: UITextField!
    @IBOutlet weak var updatePasswordBtn: UIButton!
    var securedPswrd = true
    override func viewDidLoad() {
        super.viewDidLoad()
        loaddata()
}
    func loaddata(){
        oldPasswordEyeImg.image = Images.hidePswrd
        newPasswordEyeImg.image = Images.hidePswrd
        confirmPasswordEyeImg.image = Images.hidePswrd
        oldPasswordTF.isSecureTextEntry = true
        newPasswordTF.isSecureTextEntry = true
        confirmNewPasswordTF.isSecureTextEntry = true
        self.oldPasswordVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 10)
        self.newPasswordVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 10)
        self.confirmPasswordVw.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 10)
    }
    @IBAction func oldPasswordEyeBtnAction(_ sender: Any) {
        if securedPswrd == true{
            securedPswrd = false
            oldPasswordEyeImg.image = Images.showPswrd
            oldPasswordTF.isSecureTextEntry = false
        } else{
            securedPswrd = true
            oldPasswordEyeImg.image = Images.hidePswrd
            oldPasswordTF.isSecureTextEntry = true
        }
    }
    @IBAction func newPasswordEyeBtnAction(_ sender: Any) {
        if securedPswrd == true{
            securedPswrd = false
            newPasswordEyeImg.image = Images.showPswrd
            newPasswordTF.isSecureTextEntry = false
        } else{
            securedPswrd = true
            newPasswordEyeImg.image = Images.hidePswrd
            newPasswordTF.isSecureTextEntry = true
        }
    }
    @IBAction func confirmPasswordBtnEyeBtnAction(_ sender: Any) {
        if securedPswrd == true{
            securedPswrd = false
            confirmPasswordEyeImg.image = Images.showPswrd
            confirmNewPasswordTF.isSecureTextEntry = false
        } else{
            securedPswrd = true
            confirmPasswordEyeImg.image = Images.hidePswrd
            confirmNewPasswordTF.isSecureTextEntry = true
        }
    }
    @IBAction func backBtnAction(_ sender: Any) {
        pop()
    }
    @IBAction func updatePasswordBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordSuccessPopUpVC") as! PasswordSuccessPopUpVC
        vc.passwordSuccessObj = self
        self.present(vc, animated: true, completion: nil)
    }
}
