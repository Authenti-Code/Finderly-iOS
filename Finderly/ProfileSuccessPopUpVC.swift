//
//  ProfileSuccessPopUpVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit
protocol profilePopUp: class {
    func removePopUp1(text:String)
    func removePopUp2(text:String)
}

class ProfileSuccessPopUpVC: UIViewController {

    @IBOutlet weak var oHeadingLabel: UILabel!
    var delegateObj: profilePopUp?
    var comingFromProfile:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if comingFromProfile == true{
            oHeadingLabel.text = "Your profile picture has been uploaded"
        }else{
            oHeadingLabel.text = "Your password has been updated"
        }

        
    }
    @IBAction func crossBtnAcn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitBtnAcn(_ sender: Any) {
        if comingFromProfile == true{
            self.dismiss(animated: true, completion: {
                self.delegateObj?.removePopUp1(text: "Your Text")
            })
        }else{
            self.dismiss(animated: true, completion: {
                self.delegateObj?.removePopUp2(text: "Your Text")
            })
        }
        
    }
    

}
