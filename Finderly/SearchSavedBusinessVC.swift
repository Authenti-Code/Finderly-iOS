//
//  SearchSavedBusinessVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 04/05/22.
//

import UIKit
import SVProgressHUD
import SDWebImage

class SearchSavedBusinessVC: UIViewController {
    //MARK--> Outlets
    @IBOutlet weak var oSearhSavedCollectionView: UICollectionView!
    @IBOutlet weak var oSearchVw: UIView!
    @IBOutlet weak var oSearchTF: UITextField!
    @IBOutlet weak var oEmptyLabel:UILabel!
    //MARK--> Define variable
    var businesssavedAry =  [BusinessSavedModel]()
    var cross = false
    override func viewDidLoad() {
        super.viewDidLoad()
        oEmptyLabel.isHidden = true
        oSearchTF.becomeFirstResponder()
        oSearchTF.delegate = self
        oSearhSavedCollectionView.delegate = self
        oSearhSavedCollectionView.dataSource = self
    }
    //MARK--> back button Action
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
    //MARK--> Cut/cross  button Action
    @IBAction func crossBtnAcn(_ sender: Any) {
        if cross == false{
            cross = true
            self.navigationController?.popViewController(animated: false)
            oSearchTF.text = ""
        }else{
            oSearchTF.text = ""
        }
    }
}
//MARK:--> Collection view Delegate
extension SearchSavedBusinessVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return businesssavedAry.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oSearhSavedCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchSavedBusinessCVCell", for:indexPath) as! SearchSavedBusinessCVCell
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
//MARK--> extension for Characters wise Search
extension SearchSavedBusinessVC:UITextFieldDelegate{
    //MARK:--> TextField Search product fucntion
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField == oSearchTF{
            let searchText  = oSearchTF.text! + string
            print("searchText:",searchText.count)
            if searchText.count >= 2 {
                DispatchQueue.main.async {
                    self.oEmptyLabel.isHidden = true
                    //                    self.noproductImgVw.isHidden = true
                    self.SearchSaveBusinessApi{
                        self.oSearhSavedCollectionView.delegate = self
                        self.oSearhSavedCollectionView.dataSource = self
                        self.oSearhSavedCollectionView.reloadData()
                    }
                }
            } else{
                if searchText.count <= 1{
                    businesssavedAry.removeAll()
                    //                    currentSearchPage = 1
                    //no product found
                    emptyproductFunc()
                }
            }
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == oSearchTF{
            if oSearchTF.text?.count == 0{
                //                oArenaSearchCollectionView.isHidden = true
                businesssavedAry.removeAll()
                //                currentSearchPage = 1
                emptyproductFunc()
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == oSearchTF{
            if oSearchTF.text?.count == 0{
                businesssavedAry.removeAll()
                //                currentSearchPage = 1
                emptyproductFunc()
            }
        }
    }
    //MARK:--> Empty Product
    func emptyproductFunc(){
        businesssavedAry.removeAll()
        oSearhSavedCollectionView.isHidden = true
        oEmptyLabel.isHidden = false
        //        noproductImgVw.isHidden = false
    }
    func productFunc(){
        oSearhSavedCollectionView.isHidden = false
        oEmptyLabel.isHidden = true
        //        noproductImgVw.isHidden = true
    }
}
extension SearchSavedBusinessVC{
    //MARK--> Hit Search Saved Business Api
    func SearchSaveBusinessApi(completion:@escaping() -> Void) {
        let Url = "\(Apis.KServerUrl)\(Apis.kSearchSavedBusiness)"
        SVProgressHUD.show()
        let param = ["business_name": oSearchTF.text as AnyObject,
                     "page_number": "1" as AnyObject]
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
                    if self.businesssavedAry.count == 0  {
                        self.emptyproductFunc()
                    } else{
                        self.productFunc()
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
