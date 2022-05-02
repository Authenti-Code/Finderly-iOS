//
//  RestaurantVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 03/01/22.
//

import UIKit
import SDWebImage
import SVProgressHUD

class RestaurantVC: UIViewController {
    //MARK:--> Outlets
    @IBOutlet weak var oRestaurantsCV: UICollectionView!
    @IBOutlet weak var oCategoryNameLbl: UILabel!
    var resturantModelAry = [ResturantModel]()
    //MARK:--> Define variables
    var categoryId = Int()
    var totalPage:Int?
    var pageNo : Int?
    var categoryName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        oCategoryNameLbl.text = categoryName
        oRestaurantsCV.delegate = self
        oRestaurantsCV.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        getBusinessCategory()
    }
    //MARK:--> Back button Action
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
}
//MARK:--> Collection view Delegate
extension RestaurantVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resturantModelAry.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oRestaurantsCV.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for:indexPath) as! HomeCVCell
        let resturantModelObj = resturantModelAry[indexPath.row]
        cell.oHookedMainView.layer.shadowColor = appcolor.backgroundShadow.cgColor
        cell.oHookedMainView.layer.shadowOffset = .zero
        cell.oHookedMainView.layer.shadowRadius = 3
        cell.oHookedMainView.layer.shadowOpacity = 0.3
        cell.oHookedMainView.layer.masksToBounds = false
        cell.oResturentHeadingLbl.text = resturantModelObj.name
        let imgUrl = resturantModelObj.imageIcon
        let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
        cell.oResturentImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.oResturentImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
        cell.oReseturentLocationLbl.text = resturantModelObj.location
        cell.oResturentDiscriptionLbl.text = resturantModelObj.description
        cell.oRatingLbl.text =  "\(resturantModelObj.ratings ?? "") (\(resturantModelObj.ratings_count  ?? 0 ))"
        if resturantModelObj.is_liked == 1{
            cell.oLikeBtn.setImage(UIImage(named: "liked_heart"), for: .normal)
        }else{
            cell.oLikeBtn.setImage(UIImage(named: "Icon heart"), for: .normal)
        }
        cell.oLikeBtn.tag = indexPath.row
        cell.oLikeBtn.addTarget(self, action: #selector(likeButton), for: .touchUpInside)
        return cell
    }
    @objc func likeButton( sender:UIButton){
        let resturantModelObj = resturantModelAry[sender.tag]
        businessLikeApi(id:resturantModelObj.id ?? ""){
            self.viewWillAppear(true)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2.12, height: 220)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboardMain.instantiateViewController(withIdentifier: "BusinessDetailVCID") as! BusinessDetailVC
        let resturantModelObj = resturantModelAry[indexPath.row]
        vc.businessId = (Int(resturantModelObj.id ?? "0") ?? 0)
        print("id",resturantModelObj.id)
        navigationController?.pushViewController(vc,animated: true)
        //        Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "BusinessDetailVCID", isAnimate: true, currentViewController: self)
    }
}
//MARK:--> extension for hit Get Business category Api
extension RestaurantVC{
    func getBusinessCategory(){
        SVProgressHUD.show()
        var param = [String: String]()
        var categoryData = ""
        categoryData = "\(Apis.KServerUrl)\(Apis.kGetCategoryBusinessLists)"
        param = ["category_id":"\(categoryId)","page_number":"1"]
        print("Param:\(param)")
        let kURL = categoryData.encodedURLString()
        print("kURL:->\(kURL)")
        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    SVProgressHUD.dismiss()
                    self.resturantModelAry.removeAll()
                    if let newData = JSON["data"] as? NSArray{
                        for i in 0..<newData.count{
                            let dict = newData[i]
                            let returantModelObj = ResturantModel()
                            returantModelObj.resturanr(dataDict: dict as! NSDictionary)
                            self.resturantModelAry.append(returantModelObj)
                        }
                    }
                    self.oRestaurantsCV.reloadData()
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
                    self.oRestaurantsCV.reloadData()
                    self.oRestaurantsCV.delegate = self
                    self.oRestaurantsCV.dataSource = self
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

