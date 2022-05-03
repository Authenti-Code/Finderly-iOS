//
//  HookedVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit
import SVProgressHUD
import SDWebImage

class HookedVC: UIViewController {
    //MARK:--> IBOutlets
    @IBOutlet weak var oHookedCollectionView: UICollectionView!
    //MARK:--> Define variables
    var hookedModelAry = [BuisnessHookedModel]()
    var pageNo: Int?
    var totalPage: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNo = 1
        oHookedCollectionView.delegate = self
        oHookedCollectionView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getBusinessHookedApi()
    }
}
//MARK:--> Collection view delegats
extension HookedVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hookedModelAry.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oHookedCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        let hookeModelObj = hookedModelAry[indexPath.row]
        cell.oHookedMainView.layer.shadowColor = appcolor.backgroundShadow.cgColor
        cell.oHookedMainView.layer.shadowOffset = .zero
        cell.oHookedMainView.layer.shadowRadius = 3
        cell.oHookedMainView.layer.shadowOpacity = 0.3
        cell.oHookedMainView.layer.masksToBounds = false
        let imgUrl = hookeModelObj.image
        let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
        cell.oHookedImageView.sd_imageIndicator = SDWebImageActivityIndicator.white
        cell.oHookedImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
        cell.oHookedHeadingLbl.text = hookeModelObj.buisnessName
        cell.oHookedLocationLbl.text = hookeModelObj.location
        cell.oHookedDiscriptionLbl.text = hookeModelObj.description
        cell.oRatingLabell.text = "\(hookeModelObj.ratings ?? "") (\(hookeModelObj.ratings_count  ?? 0 ))"
        if hookeModelObj.is_liked == 1{
            cell.oLikebtn.setImage(UIImage(named: "liked_heart"), for: .normal)
        }else{
            cell.oLikebtn.setImage(UIImage(named: "Icon heart"), for: .normal)
        }
        //        cell.oLikebtn.tag = indexPath.row
        //        cell.oLikebtn.addTarget(self, action: #selector(likeBtn), for: .touchUpInside)
        return cell
    }
    //MARK:--> Like Buttton
    //    @objc func likeBtn( sender:UIButton){
    //        let hookeModelObj = hookedModelAry[sender.tag]
    //        businessLikeApi(id:hookeModelObj.id ?? ""){
    //            self.viewWillAppear(true)
    //        }
    //    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if hookedModelAry.count > 0 {
            let nav = storyboardMain.instantiateViewController(withIdentifier: "BusinessDetailVCID") as! BusinessDetailVC
            let hookeModelObj = hookedModelAry[indexPath.row]
            nav.businessId = Int(hookeModelObj.id ?? "0") ?? 0
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2.12, height: 220)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if hookedModelAry.count > 0{
            if indexPath.row == hookedModelAry.count - 1{
                if totalPage! > pageNo!{
                    pageNo = pageNo! + 1
                    getBusinessHookedApi()
                }
            }
        }
    }
}
//MARK:--> extension for hit GetBusiness and business Like Api
extension HookedVC{
    func getBusinessHookedApi(){
        SVProgressHUD.show()
        var param = [String: String]()
        var categoryData = ""
        categoryData = "\(Apis.KServerUrl)\(Apis.kGetBusinessHooked)"
        param = ["page_number":"\(pageNo ?? 1)"]
        print("Param:\(param)")
        let kURL = categoryData.encodedURLString()
        print("kURL:->\(kURL)")
        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    SVProgressHUD.dismiss()
                    self.totalPage = JSON["total_pages"] as? Int
                    self.hookedModelAry.removeAll()
                    if let newData = JSON["data"] as? NSArray{
                        for i in 0..<newData.count{
                            let dict = newData[i]
                            let hookedModelObj = BuisnessHookedModel()
                            hookedModelObj.hooked(dataDict: dict as! NSDictionary)
                            self.hookedModelAry.append(hookedModelObj)
                        }
                    }
                    self.oHookedCollectionView.reloadData()
//                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                } else{
                    SVProgressHUD.dismiss()
                    Proxy.shared.displayStatusCodeAlert(JSON["errorMessage"] as? String ?? "")
                }
            } else {
                SVProgressHUD.dismiss()
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
    //MARK:--> Hit Business like and unlike Api
    func businessLikeApi(id:String,completion:@escaping() -> Void)  {
        let likeUrl = "\(Apis.KServerUrl)\(Apis.kLikebusiness)"
        let kURL = likeUrl.encodedURLString()
        let params = [
            "business_id":  id as AnyObject
        ]
        WebProxy.shared.postData(kURL, params: params, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    if let dataDict = JSON["data"] as? NSDictionary {
                        print("Dict:",dataDict)
                    }
                    completion()
                    self.oHookedCollectionView.reloadData()
                    self.oHookedCollectionView.delegate = self
                    self.oHookedCollectionView.dataSource = self
//                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                } else{
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                }
            } else {
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}
