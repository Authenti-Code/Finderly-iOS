//
//  EditProfileVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 03/01/22.
//

import UIKit
import SDWebImage
import SVProgressHUD

class EditProfileVC: UIViewController {

    @IBOutlet weak var oNameView: UIView!
    @IBOutlet weak var oNameTextField: UITextField!
    @IBOutlet weak var oPhoneView: UIView!
    @IBOutlet weak var oPhoneTextField: UITextField!
    @IBOutlet weak var oEmailView: UIView!
    @IBOutlet weak var oEmailTextField: UITextField!
    @IBOutlet weak var oUserImageView: UIImageView!
    var userDataModelObj = UserDataModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userProfileData{
            self.oNameTextField.text = "\(self.userDataModelObj.userName ?? "")"
            print("Name:-",self.oNameTextField.text as Any)
            self.oEmailTextField.text = "\(self.userDataModelObj.email ?? "")"
            self.oPhoneTextField.text = "\(self.userDataModelObj.phoneNumber ?? "")"
            self.oUserImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.oUserImageView.sd_setImage(with: URL(string: "\(self.userDataModelObj.userProfile ?? "")"), placeholderImage: UIImage(named: "user-profile"))
        }
    }
    func loadItem(){
        self.oNameView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oPhoneView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oEmailView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
    @IBAction func saveBtnAcn(_ sender: Any) {
        if oNameTextField.text?.isEmpty == true{
        Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.fullName)
        return
        }else if oPhoneTextField.text?.isEmpty == true{
            Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.phoneNumber)
            return
        }else{
            userProfileDataApi{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
extension EditProfileVC{
    //MARK:- Hit User Profile Details Api Method
    func userProfileData(completion:@escaping() -> Void)  {
        SVProgressHUD.show()
        let eduDetail = "\(Apis.KServerUrl)\(Apis.kGetProfile)"
        let kURL = eduDetail.encodedURLString()
        WebProxy.shared.postData(kURL, params: [:], showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    SVProgressHUD.dismiss()
                    if let dataDict = JSON["data"] as? NSDictionary {
                        print("Dict:",dataDict)
                        self.userDataModelObj.userInfo(dataDict:dataDict)
                    }
                    completion()
                    // Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                } else{
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                }
            } else {
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
    //MARK:--> Image Update protocol
    func updatedImage() {
        viewWillAppear(true)
    }
}
extension EditProfileVC{
    func userProfileDataApi(completion:@escaping() -> Void)  {
        let eduDetail = "\(Apis.KServerUrl)\(Apis.kUpdateProfile)"
        let kURL = eduDetail.encodedURLString()
        let params = [
            "user_name": oNameTextField.text ?? "",
            "mobile_number": oPhoneTextField.text ?? "",
            "email": oEmailTextField.text ?? ""
        ] as [String:String]
        
        WebProxy.shared.postData(kURL, params: params, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    if let dataDict = JSON["data"] as? NSDictionary {
                        print("Dict:",dataDict)
                    }
                    completion()
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                } else{
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                }
            } else {
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}
