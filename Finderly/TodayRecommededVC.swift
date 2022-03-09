//
//  TodayRecommededVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 04/01/22.
//

import UIKit
import SVProgressHUD

class TodayRecommededVC: UIViewController {
    //Post Details
    @IBOutlet weak var oListingTableView: UITableView!
    var postID : Int?
    var todayRecommededVMObj = TodayRecommededVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        todayRecommendedApi{
            self.oListingTableView.delegate = self
            self.oListingTableView.dataSource = self
            self.oListingTableView.reloadData()
        }
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
}

extension TodayRecommededVC{
    //MARK--> TODAY RECOMMENDED
    func todayRecommendedApi(completion:@escaping() -> Void){
        SVProgressHUD.show()
        let todayRecommended = "\(Apis.KServerUrl)\(Apis.kTodayRecommended)"
        let kURL = todayRecommended.encodedURLString()
        let param = ["category_id":"7","page_number":"1"]
        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    if let newData = JSON["data"] as? NSArray{
                        for i in 0..<newData.count{
                            let dict = newData[i]
                            print("Dict:",dict)
                        }
                    }
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
