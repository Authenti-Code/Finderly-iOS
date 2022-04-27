//
//  VM.swift
//  Finderly
//
//  Created by D R Thakur on 07/03/22.
//

import UIKit
import SVProgressHUD
class TodayRecommededVM{
//    func getDetailList(){
//        SVProgressHUD.show()
//        var param = [String: String]()
//        var categoryData = ""
//        categoryData = "\(Apis.KServerUrl)\(Apis.kGetCategoryBusinessLists)"
//        param = ["category_id":"\(categoryId)","page_number":"1"]
//        print("Param:\(param)")
//        let kURL = categoryData.encodedURLString()
//        print("kURL:->\(kURL)")
//        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
//            if isSuccess {
//                if JSON["success"] as? String == "true"{
//                    SVProgressHUD.dismiss()
//                    self.resturantModelAry.removeAll()
//                    if let newData = JSON["data"] as? NSArray{
//                        for i in 0..<newData.count{
//                            let dict = newData[i]
//                            let returantModelObj = ResturantModel()
//                            returantModelObj.resturanr(dataDict: dict as! NSDictionary)
//                            self.resturantModelAry.append(returantModelObj)
//                        }
//                    }
//                    self.oRestaurantsCV.reloadData()
//                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
//                } else{
//                    SVProgressHUD.dismiss()
//                    Proxy.shared.displayStatusCodeAlert(JSON["errorMessage"] as? String ?? "")
//                }
//            } else {
//                SVProgressHUD.dismiss()
//                Proxy.shared.displayStatusCodeAlert(message)
//            }
//        }
//    }
}

