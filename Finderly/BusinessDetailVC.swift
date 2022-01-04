//
//  BusinessDetailVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 04/01/22.
//

import UIKit

class BusinessDetailVC: UIViewController {
//MARK:- > IBOutlets
    @IBOutlet weak var oMainImgView: UIImageView!
    @IBOutlet weak var oBusinessNameLabel: UILabel!
    @IBOutlet weak var oDiscriptionLabel: UILabel!
    @IBOutlet weak var oLocationStack: UIStackView!
    @IBOutlet weak var oRatingView: UIView!
    @IBOutlet weak var oLocationView: UIView!
    @IBOutlet weak var oCategoryCollectionView: UICollectionView!
    @IBOutlet weak var oPhotoCollectionView: UICollectionView!
    @IBOutlet weak var oContactView: UIView!
    @IBOutlet weak var oWhatsAppView: UIView!
    @IBOutlet weak var oInstagramView: UIView!
    @IBOutlet weak var oShareView: UIView!
    @IBOutlet weak var oHookView: UIView!
    @IBOutlet weak var oSaveView: UIView!
    //MARK:-> View's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadItem()
    }
    //MARK:-> Custom Function
    func loadItem(){
        self.oRatingView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oLocationView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oContactView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oWhatsAppView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oInstagramView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oShareView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oHookView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oSaveView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
    }
    //MARK:-> Button Actions
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
    @IBAction func seeAllSpecializationBtnAcn(_ sender: Any) {
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
    }
    
}
extension BusinessDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        return cell
    }
    
    
}
