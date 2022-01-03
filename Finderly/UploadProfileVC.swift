//
//  UploadProfileVC.swift
//  Findirly
//
//  Created by D R Thakur on 24/12/21.
//

import UIKit

@available(iOS 13.0, *)
class UploadProfileVC: UIViewController {
    //MARK:--> IBOutlets
    @IBOutlet weak var ousrImgVw: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ousrImgVw.roundedImage()
    }
    @IBAction func chooseFromGalleryBtnAcn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSuccessPopUpVCID") as! ProfileSuccessPopUpVC
        vc.delegateObj = self
        vc.comingFromProfile = true
        self.present(vc, animated: true, completion: nil)
    }
}
extension UploadProfileVC: profilePopUp{
    func removePopUp1(text: String) {
        Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "CustomTabBarID", isAnimate: true, currentViewController: self)
    }
    func removePopUp2(text: String) {
        self.navigationController?.backToViewController(viewController: LoginVC.self)
    }
    
}
