//
//  SavedBusinessesVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 02/05/22.
//

import UIKit
import SDWebImage
import SVProgressHUD

class SavedBusinessesVC: UIViewController {
    //MARK--> Outlets
    @IBOutlet weak var oSavedCollectionView: UICollectionView!
    //MARK--> Define variable
    var businesssavedAry =  [BusinessSavedModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK--> Back Button Action
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
    //MARK-->   Search Button Action
    @IBAction func SearchBtnAcn(_ sender: Any) {
        let vc = storyboardMain.instantiateViewController(withIdentifier: "SearchSavedBusinessVC") as! SearchSavedBusinessVC
        navigationController?.pushViewController(vc,animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        getSaveBusinessApi{
            self.oSavedCollectionView.delegate = self
            self.oSavedCollectionView.dataSource = self
            self.oSavedCollectionView.reloadData()
        }
    }
}
//MARK:--> Collection view Delegate
extension SavedBusinessesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return businesssavedAry.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oSavedCollectionView.dequeueReusableCell(withReuseIdentifier: "SavedBusinessCVCell", for:indexPath) as! SavedBusinessCVCell
        let savedModelObj = businesssavedAry[indexPath.row]
        cell.oSavedVw.layer.shadowColor = appcolor.backgroundShadow.cgColor
        cell.oSavedVw.layer.shadowOffset = .zero
        cell.oSavedVw.layer.shadowRadius = 3
        cell.oSavedVw.layer.shadowOpacity = 0.3
        cell.oSavedVw.layer.masksToBounds = false
        cell.obusinessNameLbl.text = savedModelObj.buisnessName
        let imgUrl = savedModelObj.business_logo
        let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
        cell.oSavedImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.oSavedImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
        cell.oLocationLbl.text = savedModelObj.location
        cell.oDescriptionLbl.text = savedModelObj.description
        cell.oRatingLbl.text =  "\(savedModelObj.ratings ?? "") (\(savedModelObj.ratings_count  ?? 0 ))"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if businesssavedAry.count > 0 {
            let nav = storyboardMain.instantiateViewController(withIdentifier: "BusinessDetailVCID") as! BusinessDetailVC
            let savedModelObj = businesssavedAry[indexPath.row]
            nav.businessId = Int(savedModelObj.id ?? "0") ?? 0
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2.12, height: 220)
    }
}
//MARK-->   extension class for hit Api's
extension SavedBusinessesVC{
    //MARK--> Hit get Save Business Api
    func getSaveBusinessApi(completion:@escaping() -> Void) {
        let Url = "\(Apis.KServerUrl)\(Apis.kGetSavesBusiness)"
        SVProgressHUD.show()
        let param = ["page_number": "1" as AnyObject]
        print("Params",param)
        WebProxy.shared.postData(Url, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                let statusRes = JSON["success"] as? String ?? ""
                if statusRes == "true"{
                    SVProgressHUD.dismiss()
                    if let newData = JSON["data"] as? NSArray{
                        self.businesssavedAry.removeAll()
                        for i in 0..<newData.count{
                            let dict = newData[i]
                            let savedModelObj = BusinessSavedModel()
                            savedModelObj.saved(dataDict: dict as! NSDictionary)
                            self.businesssavedAry.append(savedModelObj)
                        }
                    }
                    completion()
                } else{
                    SVProgressHUD.dismiss()
                    Proxy.shared.displayStatusCodeAlert(JSON["errorMessage"] as? String ?? "")
                }
            } else {
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}
