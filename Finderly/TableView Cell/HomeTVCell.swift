//
//  HomeTVCell.swift
//  Finderly
//
//  Created by Pankush Mehra on 30/12/21.
//

import UIKit
import SDWebImage
protocol PostDelegate {
    func selectedPost(post: IndexPath)
}

class HomeTVCell: UITableViewCell {

    @IBOutlet weak var oHeadingLabel: UILabel!
    @IBOutlet weak var oSeeAllBtn: UIButton!
    @IBOutlet weak var oListingCollectionView: UICollectionView!
    var homeBuisnessAry = [HomeDataBusinessModel]()
    var delegateObj: PostDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        oListingCollectionView.delegate = self
        oListingCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
extension HomeTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Total CV Count:--->",homeBuisnessAry.count)
        return homeBuisnessAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeModelObj = homeBuisnessAry[indexPath.item]
        let cell = oListingCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        cell.oLocationLabel.text = homeModelObj.location
        cell.oTitleLabel.text = homeModelObj.businessName
        cell.oMainView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 5, edge: AIEdge.None, shadowSpace: 20, cornerRadius: 15)
        let imgUrl = homeModelObj.image
        let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
        cell.oListImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.oListImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 150, height: 200)
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item Selected:",delegateObj?.selectedPost(post: [indexPath.row]) as Any)
    }
}
