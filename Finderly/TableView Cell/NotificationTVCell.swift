//
//  NotificationTVCell.swift
//  Finderly
//
//  Created by Pankush Mehra on 03/01/22.
//

import UIKit

class NotificationTVCell: UITableViewCell {

    @IBOutlet weak var oMainView: UIView!
    @IBOutlet weak var oImgView: UIImageView!
    @IBOutlet weak var oHeadingLabel: UILabel!
    @IBOutlet weak var oTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
