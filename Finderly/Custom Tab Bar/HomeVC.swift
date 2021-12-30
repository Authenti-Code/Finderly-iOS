//
//  HomeVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit

class HomeVC: UIViewController {
//MARK:-> IBOutlets
    @IBOutlet weak var oBannerCollectionView: UICollectionView!
    @IBOutlet weak var oListingTableView: UITableView!
    //@IBOutlet weak var oTableViewHeight: NSLayoutConstraint!
    //MARK:-> View's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        oBannerCollectionView.delegate = self
        oBannerCollectionView.dataSource = self
        oListingTableView.delegate = self
        oListingTableView.dataSource = self
    }

}
//MARK:-> Extension for collection view delagate and datasource method
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oBannerCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.9, height: 140)
       }
}
//MARK:-> Extension for table view delagate and datasource method
extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return constantsVaribales.homeTVArry.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oListingTableView.dequeueReusableCell(withIdentifier: "HomeTVCell") as! HomeTVCell
        cell.oHeadingLabel.text = constantsVaribales.homeTVArry[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
