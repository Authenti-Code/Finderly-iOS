//
//  EditProfileVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 03/01/22.
//

import UIKit
import SDWebImage
import SVProgressHUD
import Alamofire

class EditProfileVC: UIViewController {
    @IBOutlet weak var oNameView: UIView!
    @IBOutlet weak var oNameTextField: UITextField!
    @IBOutlet weak var oPhoneView: UIView!
    @IBOutlet weak var oPhoneTextField: UITextField!
    @IBOutlet weak var oEmailView: UIView!
    @IBOutlet weak var oEmailTextField: UITextField!
    @IBOutlet weak var oUserImageView: UIImageView!
    var userDataModelObj = UserDataModel()
    var userImage: UIImage?
    var cameraBtnIsSelected = Bool()
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadItem()
        imagePicker.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userProfileData{
            self.oNameTextField.text = "\(self.userDataModelObj.userName ?? "")"
            print("Name:-",self.oNameTextField.text as Any)
            self.oEmailTextField.text = "\(self.userDataModelObj.email ?? "")"
            self.oPhoneTextField.text = "\(self.userDataModelObj.phoneNumber ?? "")"
            self.oUserImageView.sd_imageIndicator = SDWebImageActivityIndicator.white
            self.oUserImageView.sd_setImage(with: URL(string: "\(self.userDataModelObj.userProfile ?? "")"), placeholderImage: UIImage(named: "user-profile"))
        }
       
    }
    func loadItem(){
        self.oNameView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oPhoneView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
        self.oEmailView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 15, edge: AIEdge.All, shadowSpace: 25, cornerRadius: 20)
    }
    @IBAction func backBtnAcn(_ sender: Any) {
        self.pop()
    }
    @IBAction func imagePickerBtnAcn(_ sender: Any) {
        let alert = UIAlertController(title: "", message: constants.galleryCam, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ [self] (UIAlertAction)in
            let attributedString = NSAttributedString(string: "title", attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), //your font here
                NSAttributedString.Key.foregroundColor : UIColor.red
            ])
            print("Camera")
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            present(imagePicker, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default , handler:{ [self] (UIAlertAction)in
            print("Gallery")
            //            self.PostUpload()
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            present(imagePicker, animated: true)
        }))
        alert.addAction(UIAlertAction(title:"Cancel", style: .default , handler:{ [self] (UIAlertAction)in
            
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
       
    }
    @IBAction func saveBtnAcn(_ sender: Any) {
        if oNameTextField.text?.isEmpty == true{
        Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.fullName)
        return
        }else if oPhoneTextField.text?.isEmpty == true{
            Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.phoneNumber)
            return
        }else{
            profileUpdate()

        }
    }
}
//  MARK:--> extention for Image Picker
extension EditProfileVC: UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: {
            guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                return
            }
            let image =  originalImage.upOrientationImage()
            self.oUserImageView.image = image
            self.oUserImageView.image = info[.editedImage] as? UIImage
            self.userImage = image
            self.userImage = info[.editedImage] as? UIImage
        })
    }
}
extension EditProfileVC{
    //MARK:- Hit User Profile Details Api Method
    func userProfileData(completion:@escaping() -> Void)  {
        SVProgressHUD.show()
        let eduDetail = "\(Apis.KServerUrl)\(Apis.kGetProfile)"
        let kURL = eduDetail.encodedURLString()
        WebProxy.shared.postData(kURL, params: [:], showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    SVProgressHUD.dismiss()
                    if let dataDict = JSON["data"] as? NSDictionary {
                        print("Dict:",dataDict)
                        self.userDataModelObj.userInfo(dataDict:dataDict)
                    }
                    completion()
                    // Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                } else{
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                }
            } else {
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
    //MARK:--> Image Update protocol
    func updatedImage() {
        viewWillAppear(true)
    }
}
//MARK:-->   Image Upload API Handling:-
extension EditProfileVC{
    func profileUpdate(){
        var parameters = [String:AnyObject]()
        parameters = ["user_name": oNameTextField.text as AnyObject,
                      "mobile_number": oPhoneTextField.text as AnyObject] as [String : AnyObject]
        let URL = "\(Apis.KServerUrl)\(Apis.kUpdateProfile)"
        requestWith(endUrl: URL, imagedata: userImage?.jpegData(compressionQuality: 1.0), parameters: parameters)
    }
    func requestWith(endUrl: String, imagedata: Data?, parameters: [String : AnyObject]){
        let url = endUrl
        let timeStamp = Date().timeIntervalSince1970*1000
        let fileName = "image\(timeStamp).png"
        SVProgressHUD.show()
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if let data = imagedata{
                multipartFormData.append(data, withName: "image", fileName: fileName, mimeType: "image/png")
            }
        }, to:url,headers: HTTPHeaders(headers())).responseJSON{ response in
            if response.data != nil && response.error == nil {
                if let JSON = response.value as? NSDictionary {
                    if response.response?.statusCode == 200 {
                        SVProgressHUD.dismiss()
                 print("JSON data:-->",JSON)
                    self.navigationController?.popViewController(animated: true)
                        Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                } else {
                    if response.data != nil {
                        debugPrint(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!)
                    }
                }
            }
        }
    }
}
}

//extension EditProfileVC{
//    func userProfileDataApi(completion:@escaping() -> Void)  {
//        let eduDetail = "\(Apis.KServerUrl)\(Apis.kUpdateProfile)"
//        let kURL = eduDetail.encodedURLString()
//        let params = [
//            "user_name": oNameTextField.text ?? "",
//            "mobile_number": oPhoneTextField.text ?? ""
//        ] as [String:String]
//
//        WebProxy.shared.postData(kURL, params: params, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
//            if isSuccess {
//                if JSON["success"] as? String == "true"{
//                    if let dataDict = JSON["data"] as? NSDictionary {
//                        print("Dict:",dataDict)
//                    }
//                    completion()
//                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
//                } else{
//                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
//                }
//            } else {
//                Proxy.shared.displayStatusCodeAlert(message)
//            }
//        }
//    }
//}
