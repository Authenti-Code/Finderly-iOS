//
//  AreYouSurePopUpVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 10/05/22.
//

import UIKit
protocol areYouSureProtocol{
    func removeAreYouSureObjPop(addres:String)
}
class AreYouSurePopUpVC: UIViewController {
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    var areYouSureObj: areYouSureProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        noBtn.layer.shadowColor = UIColor.bbackgroundShadow.cgColor
        noBtn.layer.shadowOpacity = 0.5
        noBtn.layer.shadowRadius = 15
        noBtn.layer.shadowOffset = .zero
        noBtn.layer.masksToBounds = false
        yesBtn.layer.shadowColor = UIColor.bbackgroundShadow.cgColor
        yesBtn.layer.shadowOpacity = 0.5
        yesBtn.layer.shadowRadius = 15
        yesBtn.layer.shadowOffset = .zero
        yesBtn.layer.masksToBounds = false

    }
    @IBAction func cutBtnAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func yesBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: {
        self.areYouSureObj?.removeAreYouSureObjPop(addres :"good")
        })
    }
    @IBAction func noBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
