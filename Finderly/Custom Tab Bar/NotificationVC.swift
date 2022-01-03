//
//  NotificationVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var oNotificationTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        oNotificationTableView.delegate = self
        oNotificationTableView.dataSource = self
    }
 
}
extension NotificationVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oNotificationTableView.dequeueReusableCell(withIdentifier: "NotificationTVCell") as! NotificationTVCell
        cell.oMainView.layer.shadowColor = appcolor.backgroundShadow.cgColor
        cell.oMainView.layer.shadowOffset = .zero
        cell.oMainView.layer.shadowRadius = 5
        cell.oMainView.layer.shadowOpacity = 0.3
        cell.oMainView.layer.masksToBounds = false
        return cell
    }
    
    
}
