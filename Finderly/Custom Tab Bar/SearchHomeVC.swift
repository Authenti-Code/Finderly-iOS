//
//  SearchHomeVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 04/05/22.
//

import UIKit
import SDWebImage
import SVProgressHUD

class SearchHomeVC: UIViewController {
    //MARK:-> IBOutlets
    @IBOutlet weak var oSearchTableView: UITableView!
    @IBOutlet weak var oSearchField: UITextField!
    @IBOutlet weak var oEmptyLabel: UILabel!
    //MARK:-> Varibles
    var todaysModelAry = [TodaysRecommendModel]()
    var cross = false
    //MARK:-> View's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        oEmptyLabel.isHidden = true
        oSearchField.delegate = self
        oSearchField.becomeFirstResponder()
        self.oSearchTableView.delegate = self
        self.oSearchTableView.dataSource = self
        UserDefaults.standard.set(true, forKey: "logged_in")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func oCrossButtonAction(_ sender: Any) {
        if cross == false{
            cross = true
            oSearchField.text = ""
            self.navigationController?.popViewController(animated: false)
        }else{
            oSearchField.text = ""
        }
    }
    @IBAction func backBtnAction(_ sender: Any) {
        pop()
    }
}
//MARK:-> Extension for table view delegate and protocol method.
extension SearchHomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todaysModelAry.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oSearchTableView.dequeueReusableCell(withIdentifier: "SearchHomeTVCell") as! SearchHomeTVCell
        let businessObj = todaysModelAry[indexPath.row]
        cell.businessNameLbl.text = businessObj.businessName
        cell.descriptionLbl.text = businessObj.description
        cell.locationLbl.text = businessObj.location
        cell.ratingLbl.text = businessObj.ratings
        let imgUrl = businessObj.image
        let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
        cell.businessImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.businessImg.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
        cell.mainVw.layer.shadowColor = appcolor.backgroundShadow.cgColor
        cell.mainVw.layer.shadowOffset = .zero
        cell.mainVw.layer.shadowRadius = 2.5
        cell.mainVw.layer.shadowOpacity = 0.3
        cell.mainVw.layer.masksToBounds = false
        
        if businessObj.is_liked == 1{
            cell.likeBtn.setImage(UIImage(named: "liked_heart"), for: .normal)
        }else{
            cell.likeBtn.setImage(UIImage(named: "Icon heart"), for: .normal)
        }
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(BusinessLikeButton), for: .touchUpInside)
        return cell
    }
    @objc func BusinessLikeButton( sender:UIButton){
        let businessObj = todaysModelAry[sender.tag]
        businessLikeApi(id:businessObj.id ?? ""){
            self.viewWillAppear(true)
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if todaysModelAry.count > 0{
            let nav = storyboardMain.instantiateViewController(withIdentifier: "BusinessDetailVCID") as! BusinessDetailVC
            let businessObj = todaysModelAry[indexPath.row]
            nav.businessId = Int(businessObj.id ?? "0") ?? 0
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
}
extension SearchHomeVC:UITextFieldDelegate{
    //MARK:--> TextField Search product fucntion
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField == oSearchField{
            let searchText  = oSearchField.text! + string
            print("searchText:",searchText.count)
            if searchText.count >= 2 {
                DispatchQueue.main.async {
                    self.oEmptyLabel.isHidden = true
                    //self.noproductImgVw.isHidden = true
                    self.HomeSearchApi{
                        self.oSearchTableView.delegate = self
                        self.oSearchTableView.dataSource = self
                        self.oSearchTableView.reloadData()
                    }
                }
            } else{
                if searchText.count <= 1{
                    todaysModelAry.removeAll()
                    //no product found
                    emptyproductFunc()
                }
            }
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == oSearchField{
            if oSearchField.text?.count == 0{
                todaysModelAry.removeAll()
                emptyproductFunc()
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == oSearchField{
            if oSearchField.text?.count == 0{
                todaysModelAry.removeAll()
                emptyproductFunc()
            }
        }
    }
    //MARK:--> Empty Product
    func emptyproductFunc(){
        todaysModelAry.removeAll()
        oSearchTableView.isHidden = true
        oEmptyLabel.isHidden = false
    }
    func productFunc(){
        oSearchTableView.isHidden = false
        oEmptyLabel.isHidden = true
    }
}
//MARK:-> Extension For Home Api
extension SearchHomeVC{
    func HomeSearchApi(completion:@escaping() -> Void){
        SVProgressHUD.show()
        var param = [String: String]()
        var homeData = ""
        homeData = "\(Apis.KServerUrl)\(Apis.kSearchHome)"
        param = ["business_name": oSearchField.text ?? "",
                 "page_number":  "1"]
        print("Param:\(param)")
        let kURL = homeData.encodedURLString()
        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                SVProgressHUD.dismiss()
                if JSON["success"] as? String == "true"{
                    if let dataDict = JSON["data"] as? NSArray{
                            self.todaysModelAry.removeAll()
                            for i in 0..<dataDict.count{
                                let dict = dataDict[i]
                                let todaysRecommendModelObj = TodaysRecommendModel()
                                todaysRecommendModelObj.businessData(dataDict: dict as! NSDictionary)
                                self.todaysModelAry.append(todaysRecommendModelObj)
                                print("todaysModelAry",self.todaysModelAry.count)
                            }
                        }
                    if self.todaysModelAry.count == 0  {
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
                //                SVProgressHUD.dismiss()
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
    //MARK:-> Business like Api
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
//                            self.like = Int(dataDict["islike"] as? String ?? "0")
                        }
                        completion()
                        self.oSearchTableView.reloadData()
                        self.oSearchTableView.delegate = self
                        self.oSearchTableView.dataSource = self
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
