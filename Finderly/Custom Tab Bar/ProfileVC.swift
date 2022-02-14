//
//  ProfileVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit

class ProfileVC: UIViewController {
    //MARK:-> IBOutlets
    @IBOutlet weak var oUserImageView: UIImageView!
    @IBOutlet weak var oView1: UIView!
    @IBOutlet weak var oView2: UIView!
    @IBOutlet weak var oView3: UIView!
    @IBOutlet weak var oProfileTableView: UITableView!
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
    @IBAction func editBtnAcn(_ sender: Any) {
        Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "EditProfileVCID", isAnimate: true, currentViewController: self)
    }
    @IBAction func logoutBtnAcn(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "logged_in")
        self.navigationController?.backToViewController(viewController: LoginVC.self)
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
