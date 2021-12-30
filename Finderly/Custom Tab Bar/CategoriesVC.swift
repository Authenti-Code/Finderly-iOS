//
//  CategoriesVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit

class CategoriesVC: UIViewController {

    @IBOutlet weak var oCategoryCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        oCategoryCollectionView.delegate = self
        oCategoryCollectionView.dataSource = self
    }

}
extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return constantsVaribales.catoImageArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as! CategoryCVCell
        cell.oImageView.image = UIImage(named: constantsVaribales.catoImageArry[indexPath.row])
        cell.oHeadingLabel.text = constantsVaribales.catoHeadingArry[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2.10, height: 180)
       }
    
}
