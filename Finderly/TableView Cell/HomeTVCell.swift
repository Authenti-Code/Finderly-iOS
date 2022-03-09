//
//  HomeTVCell.swift
//  Finderly
//
//  Created by Pankush Mehra on 30/12/21.
//

import UIKit
import SDWebImage
//protocol PostDelegate {
//    func selectedPost(post: IndexPath)
//}

class HomeTVCell: UITableViewCell {
    //MARK:-> IBOutlets
    @IBOutlet weak var oHeadingLabel: UILabel!
    @IBOutlet weak var oSeeAllBtn: UIButton!
    @IBOutlet weak var oListingCollectionView: UICollectionView!
    //MARK:-> Variables
   // var homeBuisnessAry = [HomeDataBusinessModel]()
    var individualModelAry = [IndividualModel]()
    var todaysModelAry = [TodaysRecommendModel]()
    var top10ModelAry = [Top10BusinessModel]()
    var callback: ((_ id: Int) -> Void)?
   // var delegateObj: PostDelegate?
    //MARK:-> View's Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        oListingCollectionView.delegate = self
        oListingCollectionView.dataSource = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
//MARK:-> Extension for collection view delegate and datasource method
extension HomeTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if oListingCollectionView.tag == 0{
            return todaysModelAry.count
        }else if oListingCollectionView.tag == 1{
            return top10ModelAry.count
        }else{
            return individualModelAry.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oListingCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        if oListingCollectionView.tag == 0{
            let todayModelObj = todaysModelAry[indexPath.item]
            cell.oLocationLabel.text = todayModelObj.location
            cell.oTitleLabel.text = todayModelObj.businessName
            cell.oMainView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 5, edge: AIEdge.None, shadowSpace: 20, cornerRadius: 15)
            let imgUrl = todayModelObj.image
            let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
            cell.oListImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.oListImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
        }else if oListingCollectionView.tag == 1{
            let top10ModelObj = top10ModelAry[indexPath.item]
            cell.oLocationLabel.text = top10ModelObj.location
            cell.oTitleLabel.text = top10ModelObj.businessName
            cell.oMainView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 5, edge: AIEdge.None, shadowSpace: 20, cornerRadius: 15)
            let imgUrl = top10ModelObj.image
            let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
            cell.oListImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.oListImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
        }else{
            let individualModelObj = individualModelAry[indexPath.item]
            cell.oLocationLabel.text = individualModelObj.location
            cell.oTitleLabel.text = individualModelObj.businessName
            cell.oMainView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 5, edge: AIEdge.None, shadowSpace: 20, cornerRadius: 15)
            let imgUrl = individualModelObj.image
            let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
            cell.oListImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.oListImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if oListingCollectionView.tag == 0{
            let todayModelObj = todaysModelAry[indexPath.item]
            callback?(Int(todayModelObj.id ?? "0") ?? 0)
        } else if oListingCollectionView.tag == 1{
            let top10ModelObj = top10ModelAry[indexPath.item]
            callback?(Int(top10ModelObj.id ?? "0") ?? 0)
        } else{
            let individualModelObj = individualModelAry[indexPath.item]
            callback?(Int(individualModelObj.id ?? "0") ?? 0)
        }
    }
}
