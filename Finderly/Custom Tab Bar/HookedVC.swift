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

    @IBOutlet weak var oHookedCollectionView: UICollectionView!
    var hookedModelAry = [BuisnessHookedModel]()
    var pageNo: Int?
    var totalPage: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNo = 1
        getBusinessHookedApi()
        oHookedCollectionView.delegate = self
        oHookedCollectionView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

}
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
        cell.oHookedImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.oHookedImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
        cell.oHookedHeadingLbl.text = hookeModelObj.buisnessName
        cell.oHookedLocationLbl.text = hookeModelObj.location
        return cell
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
