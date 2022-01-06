//
//  RatingBusinessVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 06/01/22.
//

import UIKit

class RatingBusinessVC: UIViewController {

    @IBOutlet weak var oMainView: UIView!
    @IBOutlet weak var oButton1: UIButton!
    @IBOutlet weak var oButton2: UIButton!
    @IBOutlet weak var oButton3: UIButton!
    @IBOutlet weak var oButton4: UIButton!
    @IBOutlet weak var oButton5: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.oMainView.roundCorners([.topLeft,.topRight], radius: 30)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func button1Action(_ sender: Any) {
    }
    @IBAction func button2Action(_ sender: Any) {
    }
    @IBAction func button3Action(_ sender: Any) {
    }
    @IBAction func button4Action(_ sender: Any) {
    }
    @IBAction func button5Action(_ sender: Any) {
    }
    @IBAction func submitBtnAcn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
