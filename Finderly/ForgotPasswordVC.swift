//
//  ForgotPasswordVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 03/01/22.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var oMailView: UIView!
    @IBOutlet weak var oMailTextField: UITextField!
    @IBOutlet weak var oTickImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()
        
    }
    func loadItem(){
        self.oMailView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
    @IBAction func submitBtnAcn(_ sender: Any) {
        Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "VerificationOtpVCID", isAnimate: true, currentViewController: self)
    }
    


}
