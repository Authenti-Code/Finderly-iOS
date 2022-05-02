//
//  BusinessDetailVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 04/01/22.
//

import UIKit
import SVProgressHUD
import SDWebImage

class BusinessDetailVC: UIViewController {
    //MARK: -> IBOutlets
    @IBOutlet weak var oMainImgView: UIImageView!
    @IBOutlet weak var businessPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var oBusinessNameLabel: UILabel!
    @IBOutlet weak var oDiscriptionLabel: UILabel!
    @IBOutlet weak var oLocationLbl: UILabel!
    @IBOutlet weak var oRatingLbl: UILabel!
    @IBOutlet weak var oLocationStack: UIStackView!
    @IBOutlet weak var oRatingView: UIView!
    @IBOutlet weak var oLocationView: UIView!
    @IBOutlet weak var oCategoryCollectionView: UICollectionView!
    @IBOutlet weak var oPhotoCollectionView: UICollectionView!
    @IBOutlet weak var oTopView: UIView!
    @IBOutlet weak var oContactView: UIView!
    @IBOutlet weak var oWhatsAppView: UIView!
    @IBOutlet weak var oSpecilizationHeight: NSLayoutConstraint!
    @IBOutlet weak var oSpecializationVw: UIView!
    @IBOutlet weak var oPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var oPhotoVw: UIView!
    @IBOutlet weak var oInstagramView: UIView!
    @IBOutlet weak var oShareView: UIView!
    @IBOutlet weak var oHookView: UIView!
    @IBOutlet weak var oSaveView: UIView!
    @IBOutlet weak var oSocialView: UIView!
    var businessId:Int?
    var businessAry = [BuisnessDetailModel]()
    var businessImgAry = [BusinessImagesModel]()
    var specilizationAry =  [specializationsModel]()
    var  business_logo:String?
    var  business_name:String?
    var  location:String?
    var  ratings:String?
    var  descrip:String?
    var  ratingCount:Int?
    //MARK: -> View's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadItem()
       
        print(specilizationAry.count)
    }
    override func viewWillAppear(_ animated: Bool) {
        businessDetailApi{
            if self.businessImgAry.count > 0 {
                self.oPhotoHeight.constant = 194.5
            }else{
                self.oPhotoHeight.constant = 0
            }
            if self.specilizationAry.count > 0 {
                self.oSpecilizationHeight.constant = 95
                self.oSpecializationVw.isHidden = false
            }
            else{
                self.oSpecilizationHeight.constant = 0
                self.oSpecializationVw.isHidden = true
            }
            self.loaddata()
            print("ratingCount",self.ratingCount ?? 0)
        }
    }
    func loaddata(){
        self.oBusinessNameLabel.text = business_name
        self.oDiscriptionLabel.text = descrip
        self.oRatingLbl.text = "\(ratings ?? "")(\(ratingCount ?? 0))"
        self.oLocationLbl.text = location
        let imgUrl = business_logo
        let removeSpace = imgUrl?.replacingOccurrences(of: " ", with: "%20")
        self.oMainImgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.oMainImgView.sd_setImage(with: URL.init(string: removeSpace ?? ""), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
        oCategoryCollectionView.reloadData()
        oCategoryCollectionView.dataSource = self
        oCategoryCollectionView.delegate = self
        oPhotoCollectionView.reloadData()
        oPhotoCollectionView.dataSource = self
        oPhotoCollectionView.delegate = self
    }
    //MARK:-> Custom Function
    func loadItem(){
        self.oSocialView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oTopView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oContactView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oWhatsAppView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oInstagramView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oShareView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oHookView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oSaveView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
//        oPhotoCollectionView.delegate = self
//        oCategoryCollectionView.delegate = self
//        oPhotoCollectionView.dataSource = self
//        oCategoryCollectionView.dataSource = self
    }
    //MARK: -> Button Actions
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
    @IBAction func seeAllSpecializationBtnAcn(_ sender: Any) {
        Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "SpecializationVCID", isAnimate: true, currentViewController: self)
    }
    @IBAction func seeAllPhotoBtnAcn(_ sender: Any) {
    }
    @IBAction func contactBtnAcn(_ sender: Any) {
    }
    @IBAction func whatsappBtnAcn(_ sender: Any) {
    }
    @IBAction func instagramBtnAcn(_ sender: Any) {
    }
    @IBAction func shareBtnAcn(_ sender: Any) {
//        let image = UIImage(named: "Image")
//               
//               // set up activity view controller
//               let imageToShare = [ image! ]
//               let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
//               activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
//               
//               // exclude some activity types from the list (optional)
//               activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
//               
//               // present the view controller
//               self.present(activityViewController, animated: true, completion: nil)
           }
    @IBAction func hookBtnAcn(_ sender: Any) {
        hookedBusinessApi{}
    }
    @IBAction func saveBtnAcn(_ sender: Any) {
    }
    @IBAction func rateBusinessBtnAcn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RatingBusinessVCID") as! RatingBusinessVC
        self.present(vc, animated: true, completion: nil)
    }
}
extension BusinessDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var AryCount = Int()
        if collectionView == oCategoryCollectionView{
            AryCount = specilizationAry.count
        }
            else if collectionView == oPhotoCollectionView{
                AryCount = businessImgAry.count
            }
            return AryCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellMain = UICollectionViewCell()
        if collectionView == oCategoryCollectionView{
           
            let cell = oCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "SpeciliCategortCVCell", for: indexPath) as! SpeciliCategortCVCell
            let specilizationObj = specilizationAry[indexPath.item]
            cell.oCategoryName.text = specilizationObj.name
            cellMain =  cell
            
        }  else if collectionView == oPhotoCollectionView{
            let cell = oPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: "BusinessDetailCVCell", for: indexPath) as! BusinessDetailCVCell
            let businessImgObj = businessImgAry[indexPath.item]
            print("removeSpace",businessImgAry.count)
            let imgUrl = businessImgObj.business_images
            let removeSpace = imgUrl?.replacingOccurrences(of: " ", with: "%20")
            cell.oImageView.sd_imageIndicator = SDWebImageActivityIndicator.white
            cell.oImageView.sd_setImage(with: URL.init(string: removeSpace ?? ""), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
            cellMain =  cell
        }
     return cellMain
}
}
extension BusinessDetailVC{
   
    //MARK--> Hit Business Detail API
    func businessDetailApi(completion:@escaping() -> Void) {
       
        let Url = "\(Apis.KServerUrl)\(Apis.kBusinessDetail)"
      
            SVProgressHUD.show()
        let param = [
            "business_id": businessId as AnyObject
        ] as [String : Any]
        print("Params",param)
        WebProxy.shared.postData(Url, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                let statusRes = JSON["success"] as? String ?? ""
                if statusRes == "true"{
                    SVProgressHUD.dismiss()
                    if let dataDict = JSON["data"] as? NSDictionary{
                        self.business_logo = dataDict["business_logo"] as? String ?? ""
                        self.descrip = dataDict["description"] as? String ?? ""
                        self.business_name = dataDict["business_name"] as? String ?? ""
                        self.location = dataDict["location"] as? String ?? ""
                        self.ratings = dataDict["ratings"] as? String ?? ""
                        self.ratingCount = dataDict["ratings_count"] as? Int
                        print("ratingCount",self.ratingCount)
                        if let imgAry = dataDict["business_image"] as? NSArray{
                            self.businessImgAry.removeAll()
                            for i in 0..<imgAry.count{
                                let dict = imgAry[i]
                                let bImageObj = BusinessImagesModel()
                                bImageObj.bImage(dataDict:dict as! NSDictionary)
                                self.businessImgAry.append(bImageObj)
                                //print("ArrayCount",self.businessImgAry.count)
                            }
                        }
                        if let specializAry =  dataDict["specialization"] as? NSArray{
                            print("specializAry",specializAry)
                            self.specilizationAry.removeAll()
                            for i in 0..<specializAry.count{
                                let dict = specializAry[i]
                                let specilizObj = specializationsModel()
                                specilizObj.speciliza(dataDict:dict as! NSDictionary)
                                self.specilizationAry.append(specilizObj)
                                print(self.specilizationAry.count)
                            }
                        }
                    }
                    completion()
                } else{
                    Proxy.shared.displayStatusCodeAlert(JSON["errorMessage"] as? String ?? "")
                }
            } else {
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
    //MARK--> Hit HookedBusiness API
    func hookedBusinessApi(completion:@escaping() -> Void) {
        let Url = "\(Apis.KServerUrl)\(Apis.kHookBusiness)"
        SVProgressHUD.show()
        let param = [
            "business_id": businessId as AnyObject
        ] as [String : Any]
        print("Params",param)
        WebProxy.shared.postData(Url, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                let statusRes = JSON["success"] as? String ?? ""
                if statusRes == "true"{
                    SVProgressHUD.dismiss()
                    completion()
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                } else{
                    Proxy.shared.displayStatusCodeAlert(JSON["errorMessage"] as? String ?? "")
                }
            } else {
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
    //MARK--> Hit HookedBusiness API
    func getSpecializationApi(completion:@escaping() -> Void) {
        let Url = "\(Apis.KServerUrl)\(Apis.kSpecialization)"
        SVProgressHUD.show()
        let param = ["":""]
        print("Params",param)
        WebProxy.shared.postData(Url, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                let statusRes = JSON["success"] as? String ?? ""
                if statusRes == "true"{
                    SVProgressHUD.dismiss()
                    
                    completion()
                } else{
                    Proxy.shared.displayStatusCodeAlert(JSON["errorMessage"] as? String ?? "")
                }
            } else {
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}


