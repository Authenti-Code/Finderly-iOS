//
//  TodayRecommededVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 04/01/22.
//

import UIKit

class TodayRecommededVC: UIViewController {

    @IBOutlet weak var oListingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        oListingTableView.delegate = self
        oListingTableView.dataSource = self
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }

}
extension TodayRecommededVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oListingTableView.dequeueReusableCell(withIdentifier: "RecommendedTVCell") as! RecommendedTVCell
        cell.selectionStyle = .none
        cell.oMainView.layer.shadowColor = appcolor.backgroundShadow.cgColor
        cell.oMainView.layer.shadowOffset = .zero
        cell.oMainView.layer.shadowRadius = 3
        cell.oMainView.layer.shadowOpacity = 0.3
        cell.oMainView.layer.masksToBounds = false
        return cell
    }
    
    
}
