//
//  UploadProfileVC.swift
//  Findirly
//
//  Created by D R Thakur on 24/12/21.
//

import UIKit
import SDWebImage
import Alamofire
import SVProgressHUD

@available(iOS 13.0, *)
class UploadProfileVC: UIViewController {
    //MARK:--> IBOutlets
    @IBOutlet weak var ousrImgVw: UIImageView!
    @IBOutlet weak var oTakePhotoBtn: UIButton!
    @IBOutlet weak var oGalleryBtn: UIButton!
    let imagePickerCount = UIImagePickerController()
    var cameraIsSelected = Bool()
    var userImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        ousrImgVw.roundedImage()
        imagePickerCount.delegate = self
    }
    @IBAction func chooseFromGalleryBtnAcn(_ sender: Any) {
        if cameraIsSelected == true{
            self.oGalleryBtn.setTitle(constants.userLibrary, for: .normal)
            self.oTakePhotoBtn.setTitle(constants.userCamera, for: .normal)
            self.ousrImgVw.image = UIImage(named: "user-profile")
            self.cameraIsSelected = false
        }else{
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            present(picker, animated: true)
        }
        
    }
    @IBAction func cameraBtnAcn(_ sender: Any) {
        if cameraIsSelected == true{
            uploadImageApi()
        } else{
            imagePickerCount.sourceType = .camera
            imagePickerCount.allowsEditing = true
            present(imagePickerCount, animated: true)
        }
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
extension UploadProfileVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image : UIImage!
        if let img = info[.editedImage] as? UIImage {
            image = img
        } else if let img = info[.originalImage] as? UIImage {
            image = img
        }
        if image != nil{
            cameraIsSelected = true
            ousrImgVw.image = image
            userImage = image
            DispatchQueue.main.async {
                //self.btnCamera.titleLabel?.font = UIFont(name:"DM Sans Bold", size: 15)
                self.oTakePhotoBtn.setTitle(constants.camContinue, for: .normal)
               // self.btnChooseLibrary.titleLabel?.font =  UIFont(name:"DM Sans Bold", size: 15)
                self.oGalleryBtn.setTitle(constants.gallerEdit, for: .normal)
            }
        } else{
            cameraIsSelected = false
            ousrImgVw.image = UIImage(named: "user-profile")
        }
        picker.dismiss(animated: true,completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true,completion: nil)
    }
}
extension UploadProfileVC{
    func uploadImageApi(){
        var parameters = [String:AnyObject]()
        parameters = ["":""] as [String : AnyObject]
        let URL = "\(Apis.KServerUrl)\(Apis.kProfileUpload)"
        requestWith(endUrl: URL, imagedata: userImage?.jpegData(compressionQuality: 1.0), parameters: parameters)
    }
    func requestWith(endUrl: String, imagedata: Data?, parameters: [String : AnyObject]){
            SVProgressHUD.show()
            let url = endUrl
            let timeStamp = Date().timeIntervalSince1970*1000
            let fileName = "image\(timeStamp).png"
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                if let data = imagedata{
                    multipartFormData.append(data, withName: "image", fileName: fileName, mimeType: "image/jpeg")
                }
        }, to:url,headers: HTTPHeaders(headers())).responseJSON{ response in
            if response.data != nil && response.error == nil {
                // SVProgressHUD.dismiss()
                if let JSON = response.value as? NSDictionary {
                    print("JSON:",JSON)
                    if response.response?.statusCode == 200 {
                        SVProgressHUD.dismiss()
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSuccessPopUpVCID") as! ProfileSuccessPopUpVC
                        vc.delegateObj = self
                        vc.comingFromProfile = true
                        self.present(vc, animated: true, completion: nil)
                    }
                } else {
                    SVProgressHUD.dismiss()
                    if response.data != nil {
                        debugPrint(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!)
                    }
                }
            }
        }
    }
}
