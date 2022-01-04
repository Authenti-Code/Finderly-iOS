//
//  RecommendedTVCell.swift
//  Finderly
//
//  Created by Pankush Mehra on 04/01/22.
//

import UIKit

class RecommendedTVCell: UITableViewCell {

    @IBOutlet weak var oMainView: UIView!
    @IBOutlet weak var oTopImageView: UIImageView!
    @IBOutlet weak var oLocationLabel: UILabel!
    @IBOutlet weak var oLikeBtn: UIButton!
    @IBOutlet weak var oHeadingLabel: UILabel!
    @IBOutlet weak var oDiscriptionLabel: UILabel!
    @IBOutlet weak var oRatingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
