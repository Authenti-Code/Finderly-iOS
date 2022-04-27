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
    var todaysModelAry = [TodaysRecommendModel]()
    var totalPage:Int?
    var pageNo : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNo = 1
        oListingTableView.delegate = self
        oListingTableView.dataSource = self
        todayRecommendedApi{
        }
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
}
extension TodayRecommededVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todaysModelAry.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oListingTableView.dequeueReusableCell(withIdentifier: "RecommendedTVCell") as! RecommendedTVCell
        let recommendedObj = todaysModelAry[indexPath.row]
        //        cell.oLocationLabel.text = recommendedObj.location
        cell.oHeadingLabel.text = recommendedObj.businessName
        cell.oLocationLabel.text = recommendedObj.location
        cell.selectionStyle = .none
        cell.oMainView.layer.shadowColor = appcolor.backgroundShadow.cgColor
        cell.oMainView.layer.shadowOffset = .zero
        cell.oMainView.layer.shadowRadius = 3
        cell.oMainView.layer.shadowOpacity = 0.3
        cell.oMainView.layer.masksToBounds = false
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == todaysModelAry.count-1{
            if totalPage != nil{
                if self.pageNo  ?? 0 < self.totalPage ?? 0 {
                    self.pageNo = (self.pageNo ?? 0)+1
                        self.todayRecommendedApi {
                        }
                }
            }
        }
}
    //MARK--> Hit  today Recommended API
    func todayRecommendedApi(completion:@escaping() -> Void) {
        let Url = "\(Apis.KServerUrl)\(Apis.kTodayRecommended)"
        SVProgressHUD.show()
        let param = [
            "category_id": "7" as AnyObject,
            "page_number": pageNo as AnyObject
        ] as [String : Any]
        print("Params",param)
        WebProxy.shared.postData(Url, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                let statusRes = JSON["success"] as? String ?? ""
                if statusRes == "true"{
                    //                    self.todaysModelAry.removeAll()
                    if let newData = JSON["data"] as? NSArray{
                        for i in 0..<newData.count{
                            let dict = newData[i]
                            let todaysRecommendModelObj = TodaysRecommendModel()
                            todaysRecommendModelObj.businessData(dataDict: dict as! NSDictionary)
                            self.todaysModelAry.append(todaysRecommendModelObj)
                        }
                    }
                    let total = JSON["page_limit"] as? Int
                        if total == 0 {
                            self.totalPage = 1
                        } else{
                            self.totalPage = total
                        }
                    self.oListingTableView.delegate = self
                    self.oListingTableView.dataSource = self
                    self.oListingTableView.reloadData()
                    completion()
                } else{
                    Proxy.shared.displayStatusCodeAlert(JSON["errorMessage"] as? String ?? "")
                }
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.dismiss()
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}


