//
//  BusinessDetailVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 04/01/22.
//

import UIKit
import SVProgressHUD

class BusinessDetailVC: UIViewController {
//MARK: -> IBOutlets
    @IBOutlet weak var oMainImgView: UIImageView!
    @IBOutlet weak var oBusinessNameLabel: UILabel!
    @IBOutlet weak var oDiscriptionLabel: UILabel!
    @IBOutlet weak var oLocationStack: UIStackView!
    @IBOutlet weak var oRatingView: UIView!
    @IBOutlet weak var oLocationView: UIView!
    @IBOutlet weak var oCategoryCollectionView: UICollectionView!
    @IBOutlet weak var oPhotoCollectionView: UICollectionView!
    @IBOutlet weak var oTopView: UIView!
    @IBOutlet weak var oContactView: UIView!
    @IBOutlet weak var oWhatsAppView: UIView!
    @IBOutlet weak var oInstagramView: UIView!
    @IBOutlet weak var oShareView: UIView!
    @IBOutlet weak var oHookView: UIView!
    @IBOutlet weak var oSaveView: UIView!
    @IBOutlet weak var oSocialView: UIView!
    var businessId:Int?
    
    //MARK: -> View's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        businessDetailApi{}
        self.loadItem()
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
        oPhotoCollectionView.delegate = self
        oCategoryCollectionView.delegate = self
        oPhotoCollectionView.dataSource = self
        oCategoryCollectionView.dataSource = self
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
    }
    @IBAction func hookBtnAcn(_ sender: Any) {
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
        if collectionView == oCategoryCollectionView{
            return constantsVaribales.businessDetailLablAry.count
        }else{
            return 4
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == oCategoryCollectionView{
            let cell = oCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "BusinessDetailCVCell", for: indexPath) as! BusinessDetailCVCell
            cell.oCatHeadingLabel.text = constantsVaribales.businessDetailLablAry[indexPath.row]
            return cell
        }else{
            let cell = oPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: "BusinessDetailCVCell", for: indexPath) as! BusinessDetailCVCell
            return cell
        }
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
                if let newData = JSON["data"] as? NSDictionary{

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


