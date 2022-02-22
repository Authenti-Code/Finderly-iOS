//
//  CategoriesVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit
import SDWebImage
import SVProgressHUD

class CategoriesVC: UIViewController {

    @IBOutlet weak var oCategoryCollectionView: UICollectionView!
    var categoryListAry = [CategoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        oCategoryCollectionView.delegate = self
        oCategoryCollectionView.dataSource = self
        self.getCategoryListApi()
    }

}
extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryListAry.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as! CategoryCVCell
        let categoryObj = categoryListAry[indexPath.row]
        let imgUrl = categoryObj.imageIcon
        let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
        cell.oImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.oImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
        cell.oHeadingLabel.text = categoryObj.name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2.10, height: 180)
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1{
            Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "RestaurantVCID", isAnimate: true, currentViewController: self)
        }else{
            print("Hello")
        }
    }
}
extension CategoriesVC{
    func getCategoryListApi(){
        SVProgressHUD.show()
        var param = [String: String]()
        var categoryData = ""
        categoryData = "\(Apis.KServerUrl)\(Apis.kCategory)"
        param = ["":""]
        print("Param:\(param)")
        let kURL = categoryData.encodedURLString()
        print("kURL:->\(kURL)")
        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    SVProgressHUD.dismiss()
                    self.categoryListAry.removeAll()
                        if let newData = JSON["data"] as? NSArray{
                            for i in 0..<newData.count{
                                let dict = newData[i]
                                let categoryModelObj = CategoryModel()
                                categoryModelObj.categoryData(dataDict: dict as! NSDictionary)
                                self.categoryListAry.append(categoryModelObj)
                            }
                    }
                    self.oCategoryCollectionView.reloadData()
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
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
