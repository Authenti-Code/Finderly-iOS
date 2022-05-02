//
//  SavedBusinessesVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 02/05/22.
//

import UIKit
import SDWebImage

class SavedBusinessesVC: UIViewController {
    @IBOutlet weak var oSavedCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        oSavedCollectionView.delegate = self
        oSavedCollectionView.dataSource = self
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
}
//MARK:--> Collection view Delegate
extension SavedBusinessesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oSavedCollectionView.dequeueReusableCell(withReuseIdentifier: "SavedBusinessCVCell", for:indexPath) as! SavedBusinessCVCell
//        let resturantModelObj = resturantModelAry[indexPath.row]
//        cell.oHookedMainView.layer.shadowColor = appcolor.backgroundShadow.cgColor
//        cell.oHookedMainView.layer.shadowOffset = .zero
//        cell.oHookedMainView.layer.shadowRadius = 3
//        cell.oHookedMainView.layer.shadowOpacity = 0.3
//        cell.oHookedMainView.layer.masksToBounds = false
//        cell.oResturentHeadingLbl.text = resturantModelObj.name
//        let imgUrl = resturantModelObj.imageIcon
//        let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
//        cell.oResturentImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
//        cell.oResturentImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
//        cell.oReseturentLocationLbl.text = resturantModelObj.location
//        cell.oResturentDiscriptionLbl.text = resturantModelObj.description
//        cell.oRatingLbl.text =  "\(resturantModelObj.ratings ?? "") (\(resturantModelObj.ratings_count  ?? 0 ))"
//        if resturantModelObj.is_liked == 1{
//            cell.oLikeBtn.setImage(UIImage(named: "liked_heart"), for: .normal)
//        }else{
//            cell.oLikeBtn.setImage(UIImage(named: "Icon heart"), for: .normal)
//        }
//        cell.oLikeBtn.tag = indexPath.row
//        cell.oLikeBtn.addTarget(self, action: #selector(likeButton), for: .touchUpInside)
        return cell
    }
//    @objc func likeButton( sender:UIButton){
//        let resturantModelObj = resturantModelAry[sender.tag]
//        businessLikeApi(id:resturantModelObj.id ?? ""){
//            self.viewWillAppear(true)
//        }
//
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2.12, height: 220)
    }
    
}
