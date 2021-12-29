//
//  ProfileSuccessPopUpVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit
protocol profilePopUp: class {
    func removePopUp(text:String)
}

class ProfileSuccessPopUpVC: UIViewController {

    var delegateObj: profilePopUp?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func crossBtnAcn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitBtnAcn(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegateObj?.removePopUp(text: "Your Text")
        })
    }
    

}
