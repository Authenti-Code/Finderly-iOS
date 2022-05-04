//
//  SearchHomeTVCell.swift
//  Finderly
//
//  Created by Pankush Mehra on 04/05/22.
//

import UIKit

class SearchHomeTVCell: UITableViewCell {
    @IBOutlet weak var businessNameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var mainVw: UIView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var businessImg: UIImageView!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
