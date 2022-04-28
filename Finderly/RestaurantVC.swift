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

    @IBOutlet weak var oRestaurantsCV: UICollectionView!
    var resturantModelAry = [ResturantModel]()
    var categoryId = Int()
    var totalPage:Int?
    var pageNo : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        oRestaurantsCV.delegate = self
        oRestaurantsCV.dataSource = self
        getBusinessCategory()
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
}
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
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2.12, height: 220)
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "BusinessDetailVCID", isAnimate: true, currentViewController: self)
    }
}
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
}
