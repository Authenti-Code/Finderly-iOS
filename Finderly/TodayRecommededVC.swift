//
//  TodayRecommededVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 04/01/22.
//

import UIKit
import SVProgressHUD
import SDWebImage

class TodayRecommededVC: UIViewController {
    @IBOutlet weak var oListingTableView: UITableView!
    @IBOutlet weak var oCategoryNameLbl: UILabel!
    var postID : Int?
    var sponsoredAry =  [SponsoreModel]()
//    var todaysModelAry = [TodaysRecommendModel]()
//    var individualModelAry = [IndividualModel]()
//    var isCommingfromRecommended = Bool()
//    var isCommingfromIndividual = Bool()
    var totalPage:Int?
    var pageNo : Int?
    var category:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNo = 1
    }
    override func viewWillAppear(_ animated: Bool) {
        sponsoredApi{
            self.oListingTableView.delegate = self
            self.oListingTableView.dataSource = self
        }
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
}
extension TodayRecommededVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sponsoredAry.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oListingTableView.dequeueReusableCell(withIdentifier: "RecommendedTVCell") as! RecommendedTVCell
//        if isCommingfromRecommended == true{
//        let recommendedObj = todaysModelAry[indexPath.row]
//        cell.oHeadingLabel.text = recommendedObj.businessName
//        cell.oLocationLabel.text = recommendedObj.location
//        cell.oTopImageView.sd_imageIndicator = SDWebImageActivityIndicator.white
//        cell.oTopImageView.sd_setImage(with: URL(string: "\(recommendedObj.image ?? "")"), placeholderImage: UIImage(named: ""))
//        }
//         if isCommingfromIndividual == true{
//            let individualObj = individualModelAry[indexPath.row]
//            cell.oHeadingLabel.text = individualObj.businessName
//            cell.oLocationLabel.text = individualObj.location
//            cell.oTopImageView.sd_imageIndicator = SDWebImageActivityIndicator.white
//            cell.oTopImageView.sd_setImage(with: URL(string: "\(individualObj.image ?? "")"), placeholderImage: UIImage(named: ""))
//        }
        let sponsoreObj = sponsoredAry[indexPath.row]
        cell.oTopImageView.sd_imageIndicator = SDWebImageActivityIndicator.white
                cell.oTopImageView.sd_setImage(with: URL(string: "\(sponsoreObj.image ?? "")"), placeholderImage: UIImage(named: ""))
        
        cell.selectionStyle = .none
        cell.oMainView.layer.shadowColor = appcolor.backgroundShadow.cgColor
        cell.oMainView.layer.shadowOffset = .zero
        cell.oMainView.layer.shadowRadius = 3
        cell.oMainView.layer.shadowOpacity = 0.3
        cell.oMainView.layer.masksToBounds = false
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sponsoreObj = sponsoredAry[indexPath.row]
       if sponsoredAry.count > 0 {
           if let Url = NSURL(string: sponsoreObj.urlLink!){
               UIApplication.shared.openURL(Url as URL)
               print(Url)
              }
                   }
        }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == sponsoredAry.count-1{
//            if totalPage != nil{
//                if self.pageNo  ?? 0 < self.totalPage ?? 0 {
//                    self.pageNo = (self.pageNo ?? 0)+1
//                        self.sponsoredApi {
//                        }
//                }
//            }
//        }
//}
}
extension TodayRecommededVC {
    //MARK--> Hit  today Recommended API
    func sponsoredApi(completion:@escaping() -> Void) {
        let Url = "\(Apis.KServerUrl)\(Apis.kseeAllSponsore)"
        SVProgressHUD.show()
        let param = [
            "page_number": "1" as AnyObject
        ] as [String : Any]
        print("Params",param)
        WebProxy.shared.postData(Url, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                let statusRes = JSON["success"] as? String ?? ""
                if statusRes == "true"{
                    //                    self.todaysModelAry.removeAll()
                    if let newData = JSON["data"] as? NSArray{
                        self.sponsoredAry.removeAll()
                        for i in 0..<newData.count{
                            let dict = newData[i]
                            let sponsoreModelObj = SponsoreModel()
                            sponsoreModelObj.sponsored(dataDict: dict as! NSDictionary)
                            self.sponsoredAry.append(sponsoreModelObj)
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
////MARK--> Hit  invidual BusinessAPI
//func individualBusiness(completion:@escaping() -> Void) {
//    let Url = "\(Apis.KServerUrl)\(Apis.kIndividualBusiness)"
//    SVProgressHUD.show()
//    let param = [
//        "category_id": "7" as AnyObject,
//        "page_number": pageNo as AnyObject
//    ] as [String : Any]
//    print("Params",param)
//    WebProxy.shared.postData(Url, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
//        if isSuccess {
//            let statusRes = JSON["success"] as? String ?? ""
//            if statusRes == "true"{
//                //                    self.todaysModelAry.removeAll()
//                if let newData =  JSON["data"] as? NSArray{
//                    for i in 0..<newData.count{
//                        let dict = newData[i]
//                        let individualModelObj = IndividualModel()
//                        individualModelObj.businessData(dataDict: dict as! NSDictionary)
//                        self.individualModelAry.append(individualModelObj)
//                    }
//                }
//                let total = JSON["page_limit"] as? Int
//                    if total == 0 {
//                        self.totalPage = 1
//                    } else{
//                        self.totalPage = total
//                    }
//                self.oListingTableView.delegate = self
//                self.oListingTableView.dataSource = self
//                self.oListingTableView.reloadData()
//                completion()
//            } else{
//                Proxy.shared.displayStatusCodeAlert(JSON["errorMessage"] as? String ?? "")
//            }
//            SVProgressHUD.dismiss()
//        } else {
//            SVProgressHUD.dismiss()
//            Proxy.shared.displayStatusCodeAlert(message)
//        }
//    }
//}
//}
//
}
