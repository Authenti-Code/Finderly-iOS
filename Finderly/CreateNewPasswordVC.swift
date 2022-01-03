//
//  CreateNewPasswordVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 03/01/22.
//

import UIKit

class CreateNewPasswordVC: UIViewController {

    @IBOutlet weak var oPasswordView: UIView!
    @IBOutlet weak var oPasswordTF: UITextField!
    @IBOutlet weak var oPassEyeBtn: UIButton!
    @IBOutlet weak var oPassEyeImgVw: UIImageView!
    @IBOutlet weak var oConfirmPassView: UIView!
    @IBOutlet weak var oConfirmTF: UITextField!
    @IBOutlet weak var oConfirmEyeImgVw: UIImageView!
    @IBOutlet weak var oConfirmEyeBtn: UIButton!
    var securedPswrd = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadItem()
        
    }
    func loadItem(){
        oPassEyeImgVw.image = Images.hidePswrd
        oConfirmEyeImgVw.image = Images.hidePswrd
        oPasswordTF.isSecureTextEntry = true
        oConfirmTF.isSecureTextEntry = true
        self.oPasswordView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oConfirmPassView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
    }
    @IBAction func passEyeBtnAcn(_ sender: Any) {
        if securedPswrd == true{
            securedPswrd = false
            oPassEyeImgVw.image = Images.showPswrd
            oPasswordTF.isSecureTextEntry = false
        } else{
            securedPswrd = true
            oPassEyeImgVw.image = Images.hidePswrd
            oPasswordTF.isSecureTextEntry = true
        }
    }
    @IBAction func confirmEyeBtnAcn(_ sender: Any) {
        if securedPswrd == true{
            securedPswrd = false
            oConfirmEyeImgVw.image = Images.showPswrd
            oConfirmTF.isSecureTextEntry = false
        } else{
            securedPswrd = true
            oConfirmEyeImgVw.image = Images.hidePswrd
            oConfirmTF.isSecureTextEntry = true
        }
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
    @IBAction func updatePassBtnAcn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSuccessPopUpVCID") as! ProfileSuccessPopUpVC
        vc.delegateObj = self
        vc.comingFromProfile = false
        self.present(vc, animated: true, completion: nil)
    }
}
extension CreateNewPasswordVC: profilePopUp{
    func removePopUp1(text: String) {
        Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "CustomTabBarID", isAnimate: true, currentViewController: self)
    }
    func removePopUp2(text: String) {
        self.navigationController?.backToViewController(viewController: LoginVC.self)
    }
    
}

