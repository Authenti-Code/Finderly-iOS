//
//  ProfileVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit
import SDWebImage
import SVProgressHUD

class ProfileVC: UIViewController {
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
            self.oUserImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
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
        }else{
            cell.oNotifySwitch.isHidden = true
        }
        return cell
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
                if JSON["success"] as? String == "true"{
                    SVProgressHUD.dismiss()
                    if let dataDict = JSON["data"] as? NSDictionary {
                        print("Dict:",dataDict)
                        self.userModelObj.userInfo(dataDict:dataDict)
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
                if JSON["success"] as? String == "true"{
                    accessToken = ""
                    completion()
                    SVProgressHUD.dismiss()
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                } else{
                    SVProgressHUD.dismiss()
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                }
            } else {
                SVProgressHUD.dismiss()
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}
