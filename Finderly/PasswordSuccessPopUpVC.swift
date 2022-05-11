//
//  PasswordSuccessPopUpVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 10/05/22.
//

import UIKit
protocol PasswordSuccessProtocol{
    func removeRasswordSuccessObjPop(Address:String)
}
class PasswordSuccessPopUpVC: UIViewController {
    @IBOutlet weak var okBtn: UIButton!
    var passwordSuccessObj: PasswordSuccessProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

}
    @IBAction func okBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: {
        self.passwordSuccessObj?.removeRasswordSuccessObjPop(Address: "good")
        })
    }
    @IBAction func cutBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
