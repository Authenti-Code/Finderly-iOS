//
//  ProfileVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit
import SDWebImage
import SVProgressHUD

class ProfileVC: UIViewController, areYouSureProtocol {
    func removeAreYouSureObjPop(addres: String) {
        let vc = storyboardMain.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        self.navigationController?.pushViewController(vc,animated: true)
    }
    //MARK:-> IBOutlets
    @IBOutlet weak var oUserImageView: UIImageView!
    @IBOutlet weak var oView1: UIView!
    @IBOutlet weak var oView2: UIView!
    @IBOutlet weak var oView3: UIView!
    @IBOutlet weak var oProfileTableView: UITableView!
    @IBOutlet weak var oNameLabel: UILabel!
    @IBOutlet weak var oEmailLabel: UILabel!
    @IBOutlet weak var oPhoneLabel: UILabel!
    var userModelObj = UserDataModel()
    var isSelected = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadItem()
    }
    func loadItem(){
        self.oView1.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oView2.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oView3.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        oProfileTableView.delegate = self
        oProfileTableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userProfileData {
            self.oNameLabel.text = self.userModelObj.userName
            self.oEmailLabel.text = self.userModelObj.email
            self.oPhoneLabel.text = self.userModelObj.phoneNumber
            self.oUserImageView.sd_imageIndicator = SDWebImageActivityIndicator.white
            self.oUserImageView.sd_setImage(with: URL(string: "\(self.userModelObj.userProfile ?? "")"), placeholderImage: UIImage(named: "user-profile"))
        }
    }
    @IBAction func editBtnAcn(_ sender: Any) {
        Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "EditProfileVCID", isAnimate: true, currentViewController: self)
    }
    @IBAction func logoutBtnAcn(_ sender: Any) {
        logOut {
            UserDefaults.standard.set(false, forKey: "logged_in")
            let vc = storyboardMain.instantiateViewController(withIdentifier: "LoginVCID") as! LoginVC
            self.navigationController?.pushViewController(vc,animated: true)
        }
    }
}
//MARK:-> Extension for table view delegate and protocol method.
extension ProfileVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return constantsVaribales.profileLabelAry.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oProfileTableView.dequeueReusableCell(withIdentifier: "ProfileTVCell") as! ProfileTVCell
        cell.oHeadingLabel.text = constantsVaribales.profileLabelAry[indexPath.row]
        cell.oImageView.image = UIImage(named: constantsVaribales.profileImgAry[indexPath.row])
        cell.selectionStyle = .none
        if indexPath.row == 0{
            cell.oNotifySwitch.isHidden = false
            if isSelected == 1{
                cell.oNotifySwitch.isOn = true
                cell.oNotifySwitch.tintColor = .blue
            } else{
                cell.oNotifySwitch.isOn = false
                cell.oNotifySwitch.tintColor = .white
            }
        } else{
            cell.oNotifySwitch.isHidden = true
        }
        cell.oNotifySwitch.tag = indexPath.row // for detect which row switch Changed
        cell.oNotifySwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4{
            let nav = storyboardMain.instantiateViewController(withIdentifier: "SavedBusinessesVC") as! SavedBusinessesVC
            self.navigationController?.pushViewController(nav, animated: true)
        }
        if indexPath.row == 5{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AreYouSurePopUpVC") as! AreYouSurePopUpVC
            vc.areYouSureObj = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    //MARK:--> Switch
    @objc func switchChanged(_ sender : UISwitch!){
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
        if isSelected == 1{
            isSelected = 0
        } else{
            isSelected = 1
        }
        changeNotificationStatusApi(status: isSelected)
        oProfileTableView.reloadData()
    }
}
extension ProfileVC{
    //MARK:- Hit User Profile Details Api Method
    func userProfileData(completion:@escaping() -> Void)  {
        SVProgressHUD.show()
        let eduDetail = "\(Apis.KServerUrl)\(Apis.kGetProfile)"
        let kURL = eduDetail.encodedURLString()
        WebProxy.shared.postData(kURL, params: [:], showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                SVProgressHUD.dismiss()
                if JSON["success"] as? String == "true"{
                    SVProgressHUD.dismiss()
                    if let dataDict = JSON["data"] as? NSDictionary {
                        self.userModelObj.userInfo(dataDict:dataDict)
                    }
                    completion()
                } else{
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                }
            } else {
                SVProgressHUD.dismiss()
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
    //MARK:--> Change Notification Status Api
    func changeNotificationStatusApi(status: Int){
        SVProgressHUD.show()
        let notificationUrl = "\(Apis.KServerUrl)\(Apis.kNotificationStatus)"
        let kURL = notificationUrl.encodedURLString()
        let param = ["status": "\(status)"]
        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                } else{
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                }
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.dismiss()
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}
extension ProfileVC{
    //logout
    func logOut(completion:@escaping() -> Void)  {
        SVProgressHUD.show()
        let forgot = "\(Apis.KServerUrl)\(Apis.kLogout)"
        let kURL = forgot.encodedURLString()
        let param = [
            "device_id":"\(UIDevice.current.identifierForVendor?.uuidString ?? "")"
        ] as [String:String]
        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { [] (JSON, isSuccess, message) in
            if isSuccess {
                SVProgressHUD.dismiss()
                if JSON["success"] as? String == "true"{
                    accessToken = ""
                    completion()
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                } else{
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                }
            } else {
                SVProgressHUD.dismiss()
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}
