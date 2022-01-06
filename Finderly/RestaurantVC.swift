//
//  RestaurantVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 03/01/22.
//

import UIKit

class RestaurantVC: UIViewController {

    @IBOutlet weak var oRestaurantsCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        oRestaurantsCV.delegate = self
        oRestaurantsCV.dataSource = self
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
}
extension RestaurantVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oRestaurantsCV.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for:indexPath) as! HomeCVCell
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "BusinessDetailVCID", isAnimate: true, currentViewController: self)
    }
}
