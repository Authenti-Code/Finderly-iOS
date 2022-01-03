//
//  EditProfileVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 03/01/22.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var oNameView: UIView!
    @IBOutlet weak var oNameTextField: UITextField!
    @IBOutlet weak var oPhoneView: UIView!
    @IBOutlet weak var oPhoneTextField: UITextField!
    @IBOutlet weak var oEmailView: UIView!
    @IBOutlet weak var oEmailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadItem()
    }
    func loadItem(){
        self.oNameView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oPhoneView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oEmailView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
    @IBAction func saveBtnAcn(_ sender: Any) {
    }
    

}
