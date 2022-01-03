//
//  HookedVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit

class HookedVC: UIViewController {

    @IBOutlet weak var oHookedCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        oHookedCollectionView.delegate = self
        oHookedCollectionView.dataSource = self
        
    }

}
extension HookedVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oHookedCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        cell.oHookedMainView.layer.shadowColor = appcolor.backgroundShadow.cgColor
        cell.oHookedMainView.layer.shadowOffset = .zero
        cell.oHookedMainView.layer.shadowRadius = 3
        cell.oHookedMainView.layer.shadowOpacity = 0.3
        cell.oHookedMainView.layer.masksToBounds = false
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2.12, height: 220)
       }
}
