//
//  SpecializationVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 06/01/22.
//

import UIKit

class SpecializationVC: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var oListCollectionView: UICollectionView!
    // MARK: - View'Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadItem()
    }
    func loadItem(){
        oListCollectionView.delegate = self
        oListCollectionView.dataSource = self
    }
    // MARK: - Button Action
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }

}
extension SpecializationVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return constantsVaribales.specializationLabelAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oListCollectionView.dequeueReusableCell(withReuseIdentifier: "BusinessDetailCVCell", for: indexPath) as! BusinessDetailCVCell
        cell.oCatHeadingLabel.text = constantsVaribales.specializationLabelAry[indexPath.row]
        return cell
    }
    
    
}
