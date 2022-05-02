//
//  HomeCVCell.swift
//  Finderly
//
//  Created by Pankush Mehra on 30/12/21.
//

import UIKit

class HomeCVCell: UICollectionViewCell {
    @IBOutlet weak var constimgVwheight: NSLayoutConstraint!
    // MARK:-> Banner Cell's Outlets
    @IBOutlet weak var oTopMainView: UIView!
    @IBOutlet weak var oTopImageView: UIImageView!
    //MARK:-> Listing Cell's Outlet
    @IBOutlet weak var oListImageView: UIImageView!
    @IBOutlet weak var oTitleLabel: UILabel!
    @IBOutlet weak var oDiscriptionLabel: UILabel!
    @IBOutlet weak var oRatingLabel: UILabel!
    @IBOutlet weak var oLikeUnlikeBtn: UIButton!
    @IBOutlet weak var oMainView: UIView!
    @IBOutlet weak var olocaionVw: UIView!
    @IBOutlet weak var olikeVw: UIView!
    @IBOutlet weak var oRatingImg: UIImageView!
    @IBOutlet weak var oLocationLabel: UILabel!
    //MARK:-> Hooked Cell's Outlet
    @IBOutlet weak var oHookedMainView: UIView!
    @IBOutlet weak var oHookedImageView: UIImageView!
    @IBOutlet weak var oHookedHeadingLbl: UILabel!
    @IBOutlet weak var oHookedDiscriptionLbl: UILabel!
    @IBOutlet weak var oRatingLabell: UILabel!
    @IBOutlet weak var oLikebtn: UIButton!
    @IBOutlet weak var oHookedLocationLbl: UILabel!
    //MARK:-> Resturant Cell's Outlet
    @IBOutlet weak var oResturentImageView: UIImageView!
    @IBOutlet weak var oResturentHeadingLbl: UILabel!
    @IBOutlet weak var oResturentDiscriptionLbl: UILabel!
    @IBOutlet weak var oReseturentLocationLbl: UILabel!
    @IBOutlet weak var oRatingLbl: UILabel!
    @IBOutlet weak var oLikeBtn: UIButton!
    
    override func awakeFromNib() {
    super.awakeFromNib()
    
}
}
