//
//  RatingBusinessVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 06/01/22.
//

import UIKit
import SVProgressHUD
protocol RatingBusinessProtocol{
    func ratingBusinessObjPop(rating:Int?)
}

class RatingBusinessVC: UIViewController {
    //MARK:-> IBOutlets
    @IBOutlet weak var oMainView: UIView!
    @IBOutlet weak var oButton1: UIButton!
    @IBOutlet weak var oButton2: UIButton!
    @IBOutlet weak var oButton3: UIButton!
    @IBOutlet weak var oButton4: UIButton!
    @IBOutlet weak var oButton5: UIButton!
    @IBOutlet weak var oDescriptionTVw: UITextView!
    //MARK:-> Define variable
    var callbackRating: ((_ rating:Int ,_ indx:Int) -> Void)?
    //    var ratingObj = ratingModel()
    var businessID:Int?
    var rate:Int?
    var btn1 = false
    var btn2 = false
    var btn3 = false
    var btn4 = false
    var btn5 = false
    var rat:Int?
    var ratingBusinessObj : RatingBusinessProtocol?
    //MARK:-> View's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.oMainView.roundCorners([.topLeft,.topRight], radius: 30)
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    //MARK:-> Button1 Actions
    @IBAction func button1Action(_ sender: Any) {
        btn1 = true
        btn2 = false
        btn3 = false
        btn4 = false
        btn5 = false
        self.rate = 1
        oButton1.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton2.setImage(UIImage(named: "star-gray"), for: .normal)
        oButton3.setImage(UIImage(named: "star-gray"), for: .normal)
        oButton4.setImage(UIImage(named: "star-gray"), for: .normal)
        oButton5.setImage(UIImage(named: "star-gray"), for: .normal)
    }
    //MARK:-> Button2 Actions
    @IBAction func button2Action(_ sender: Any) {
        btn1 = true
        btn2 = true
        btn3 = false
        btn4 = false
        btn5 = false
        self.rate = 2
        oButton1.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton2.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton3.setImage(UIImage(named: "star-gray"), for: .normal)
        oButton4.setImage(UIImage(named: "star-gray"), for: .normal)
        oButton5.setImage(UIImage(named: "star-gray"), for: .normal)
    }
    //MARK:-> Button3 Actions
    @IBAction func button3Action(_ sender: Any) {
        btn1 = true
        btn2 = true
        btn3 = true
        btn4 = false
        btn5 = false
        self.rate = 3
        oButton1.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton2.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton3.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton4.setImage(UIImage(named: "star-gray"), for: .normal)
        oButton5.setImage(UIImage(named: "star-gray"), for: .normal)
    }
    //MARK:-> Button4 Actions
    @IBAction func button4Action(_ sender: Any) {
        btn1 = true
        btn2 = true
        btn3 = true
        btn4 = true
        btn5 = false
        self.rate = 4
        oButton1.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton2.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton3.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton4.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton5.setImage(UIImage(named: "star-gray"), for: .normal)
    }
    //MARK:-> Button5 Actions
    @IBAction func button5Action(_ sender: Any) {
        btn1 = true
        btn2 = true
        btn3 = true
        btn4 = true
        btn5 = true
        self.rate = 5
        oButton1.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton2.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton3.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton4.setImage(UIImage(named: "star-yellow"), for: .normal)
        oButton5.setImage(UIImage(named: "star-yellow"), for: .normal)
    }
    @IBAction func submitBtnAcn(_ sender: Any) {
            self.businessRatingApi(){
                self.callbackRating?(Int(self.rat ?? 0), 0)
                self.dismiss(animated: true,completion:nil)
            }
                     }
                     @IBAction func downBtnAcn(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
                     }
                     extension RatingBusinessVC{
            //MARK--> Hit business Rating Api
            func businessRatingApi(completion:@escaping() -> Void) {
                let Url = "\(Apis.KServerUrl)\(Apis.kBusinessRating)"
                SVProgressHUD.show()
                let param = ["business_id": businessID as AnyObject ,
                             "rating": rate as AnyObject,
                             "description": oDescriptionTVw.text as AnyObject] as [String : Any]
                print("Params",param)
                WebProxy.shared.postData(Url, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
                    if isSuccess {
                        let statusRes = JSON["success"] as? String ?? ""
                        if statusRes == "true"{
                            SVProgressHUD.dismiss()
                            if let dataDict = JSON["data"] as? NSDictionary {
                                self.rat = Int(dataDict["rating"] as? String ?? "0")
                            }
                            completion()
                            self.viewWillAppear(true)
                        } else{
                            SVProgressHUD.dismiss()
                            NotificationAlert().NotificationAlert(titles: JSON["errorMessage"] as? String ?? "")
                            Proxy.shared.displayStatusCodeAlert(JSON["errorMessage"] as? String ?? "")
                        }
                    } else {
                        Proxy.shared.displayStatusCodeAlert(message)
                    }
                }
            }
        }
