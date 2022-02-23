//
//  NotificationVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit
import SVProgressHUD
import SDWebImage

class NotificationVC: UIViewController {

    @IBOutlet weak var oNotificationTableView: UITableView!
    var currentPage: Int?
    var totalPage: Int?
    var notificationModelAry = [NotificationModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getNotificationList()
        currentPage = 1
        oNotificationTableView.delegate = self
        oNotificationTableView.dataSource = self
    }
 
}
extension NotificationVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationModelAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oNotificationTableView.dequeueReusableCell(withIdentifier: "NotificationTVCell") as! NotificationTVCell
        let notificationModelObj = notificationModelAry[indexPath.item]
        cell.selectionStyle = .none
        cell.oMainView.layer.shadowColor = appcolor.backgroundShadow.cgColor
        cell.oMainView.layer.shadowOffset = .zero
        cell.oMainView.layer.shadowRadius = 5
        cell.oMainView.layer.shadowOpacity = 0.3
        cell.oMainView.layer.masksToBounds = false
        cell.oHeadingLabel.text = notificationModelObj.discription
        cell.oTimeLabel.text = notificationModelObj.time
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if notificationModelAry.count > 0{
            if indexPath.row == notificationModelAry.count - 1 {
                if totalPage! > currentPage!{
                    currentPage = currentPage! + 1
                    getNotificationList()
                }
            }
        }
    }
}
extension NotificationVC{
    func getNotificationList(){
        SVProgressHUD.show()
        let sendRqst = "\(Apis.KServerUrl)\(Apis.kNotification)"
        let kURL = sendRqst.encodedURLString()
        let params = [
            "page_number":  "\(self.currentPage ?? 1)"
        ] as [String:String]
        print("Param:", params as Any)
        WebProxy.shared.postData(kURL, params: params, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    print("Success")
                    self.totalPage = JSON["total_pages"] as? Int
                    if let dataArray = JSON["data"] as? NSArray{
                        for i in 0..<dataArray.count {
                            if let dataDict = dataArray[i] as? NSDictionary {
                                let notificationModelObj = NotificationModel()
                                notificationModelObj.notificationDict(dataDict: dataDict)
                                self.notificationModelAry.append(notificationModelObj)
                                SVProgressHUD.dismiss()
                            }
                        }
                    }
                    self.oNotificationTableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            } else {
                SVProgressHUD.dismiss()
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}
