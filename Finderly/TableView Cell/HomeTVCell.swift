//
//  HomeTVCell.swift
//  Finderly
//
//  Created by Pankush Mehra on 30/12/21.
//

import UIKit

class HomeTVCell: UITableViewCell {

    @IBOutlet weak var oHeadingLabel: UILabel!
    @IBOutlet weak var oSeeAllBtn: UIButton!
    @IBOutlet weak var oListingCollectionView: UICollectionView!
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
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oListingCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        cell.oMainView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 5, edge: AIEdge.None, shadowSpace: 20, cornerRadius: 15)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 150, height: 200)
       }
}
