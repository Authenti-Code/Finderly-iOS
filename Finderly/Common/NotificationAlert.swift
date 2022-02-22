//
//  NotificationAlert.swift
//  ALLAG
//
//  Created by Tech Farmerz on 18/10/18.
//  Copyright © 2018 Gagn deep. All rights reserved.
//

import Foundation
import BRYXBanner
class NotificationAlert {
    
    func NotificationAlert(titles:String){
        let banner = Banner(title: "Finderly", subtitle: titles,image: nil, backgroundColor: #colorLiteral(red: 0.2948374152, green: 0.2974476516, blue: 0.2906907201, alpha: 1))
        banner.dismissesOnTap = true
        banner.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        banner.titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        banner.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        banner.imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        banner.imageView.image = UIImage(named: "")
//        banner.imageView.cornerRadius = 3
        banner.show(duration: 3.0)
        }
}
