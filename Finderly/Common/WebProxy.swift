//
//  WebProxy.swift
//   DigiImpact
//
//  Created by desh raj thakur on 03/09/20.
//  Copyright © 2020 Swift Developers. All rights reserved.
//

import UIKit
import Alamofire

class WebProxy {
    
    static var shared: WebProxy {
        return WebProxy()
    }
    fileprivate init() {}
    
    //MARK:- Post Data API Interaction
    func postData(_ urlStr: String, params: [String:Any], showIndicator: Bool,methodType: HTTPMethod,completion: @escaping (_ response: NSDictionary,_ isSuccess: Bool,_ message: String) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
//            if showIndicator {
//                Proxy.shared.showActivityIndicator()
//            }
            debugPrint("URL: ",urlStr)
            debugPrint("Params: ", params)
            debugPrint("Headers:",headers())
            AF.request(urlStr, method: methodType, parameters: params, encoding: URLEncoding.httpBody, headers: HTTPHeaders(headers())).responseJSON { response in
                DispatchQueue.main.async {
                   // Proxy.shared.hideActivityIndicator()
                    print("Response:",response.data)
                    if response.data != nil && response.error == nil {
                        print("Data:", response.data)
                        if let JSON = response.value as? NSDictionary {
                            debugPrint("JSON", JSON)
                            if response.response?.statusCode == 200 {
                                completion(JSON,true, "")
                            } else {
                                if response.response?.statusCode == 400{
                                    completion(JSON,false, "")
                                } else if response.response?.statusCode == 401 {
                                    let errorMsg = JSON["error"] as? String ??  JSON["message"] as? String ?? AppAlerts.titleValue.error
                                    completion([:],false, errorMsg)
                                } else if response.response?.statusCode == 426 {
                                    let errorMsg = JSON["error"] as? String ??  JSON["message"] as? String ?? AppAlerts.titleValue.error
                                    completion([:],false, errorMsg)
                                } else {
                                    if let errorMsg =  JSON["errors"] as? NSDictionary{
                                        if let msgError = errorMsg["username"] as? NSArray{
                                            Proxy.shared.displayStatusCodeAlert(msgError[0] as? String ?? "")
                                        }
                                        if let msgError = errorMsg["phone"] as? NSArray{
                                            Proxy.shared.displayStatusCodeAlert(msgError[0] as? String ?? "")
                                        }
                                        if let msgError = errorMsg["password"] as? NSArray{
                                            Proxy.shared.displayStatusCodeAlert(msgError[0] as? String ?? "")
                                        }
                                        if let msgError = errorMsg["email"] as? NSArray{
                                            Proxy.shared.displayStatusCodeAlert(msgError[0] as? String ?? "")
                                        }
                                    }
                                    if let errorMsg = JSON["details"] as? String {
                                        Proxy.shared.displayStatusCodeAlert(errorMsg)
                                    }
                                    let errorMsg = JSON["error"] as? String ??  JSON["message"] as? String ?? AppAlerts.titleValue.error
                                    completion([:],false, errorMsg)
                                }
                            }
                        } else {
                           // Proxy.shared.hideActivityIndicator()
                            Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.ErrorUnabletoencodeJSONResponse)
                            if response.data != nil {
                                debugPrint(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? AppAlerts.titleValue.error)
                            }
                        }
                    } else {
                        if response.data != nil {
                            debugPrint(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? AppAlerts.titleValue.error)
                        }
                        self.statusHandler(response.response, data: response.data, error: response.error as NSError?)
                    }
                }
            }
        } else {
            //Proxy.shared.hideActivityIndicator()
            Proxy.shared.openSettingApp()
        }
    }
    
    //MARK:- Get Data API Interaction
    func getData(_ urlStr: String, showIndicator: Bool, completion: @escaping(_ response: NSDictionary,_ responseAry: NSArray,_ isSuccess: Bool,_ message: String) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            if showIndicator {
                //Proxy.shared.showActivityIndicator()
            }
            debugPrint("URL: ",urlStr)
            debugPrint("Header: ", headers())
            AF.request(urlStr, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders(headers()))
                .responseJSON { response in
                    print(response.response?.statusCode)
                    if response.data != nil && response.error == nil {
                       // Proxy.shared.hideActivityIndicator()
                        if response.response?.statusCode == 200 {
                            if let JSON = response.value as? NSDictionary{
                                debugPrint("JSON", JSON)
                                completion(JSON,[],true,"")
                            }
                            if let jsonAry = response.value as? NSArray{
                                debugPrint("JSONArry:", jsonAry)
                                completion(response.value as? NSDictionary ?? [:],jsonAry,true,"")
                            }
                        } else{
                            if let JSON = response.value as? NSDictionary{
                                if response.response?.statusCode == 401 {
                                    let errorMsg = JSON["error"] as? String ??  JSON["message"] as? String ?? AppAlerts.titleValue.error
                                    Proxy.shared.displayStatusCodeAlert(errorMsg)
                                } else if response.response?.statusCode == 404{
                                    completion(JSON,[],false,"")
                                }else if response.response?.statusCode == 426 {
                                    let errorMsg = JSON["error"] as? String ??  JSON["message"] as? String ?? AppAlerts.titleValue.error
                                    Proxy.shared.displayStatusCodeAlert(errorMsg)
                                }
                            }
                        }
                    } else {
                        if let JSON = response.value as? NSDictionary{
                            if response.response?.statusCode == 401 {
                                let errorMsg = JSON["error"] as? String ??  JSON["message"] as? String ?? AppAlerts.titleValue.error
                                Proxy.shared.displayStatusCodeAlert(errorMsg)
                            } else if response.response?.statusCode == 404{
                                completion(JSON,[],false,"")
                            }else if response.response?.statusCode == 426 {
                                let errorMsg = JSON["error"] as? String ??  JSON["message"] as? String ?? AppAlerts.titleValue.error
                                Proxy.shared.displayStatusCodeAlert(errorMsg)
                            }
                        }
                     //   Proxy.shared.hideActivityIndicator()
                        if response.data != nil {
                            debugPrint(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!)
                        }
                        self.statusHandler(response.response, data: response.data, error: response.error as NSError?)
                    }
                }
        } else {
           // Proxy.shared.hideActivityIndicator()
            Proxy.shared.openSettingApp()
        }
    }
    
    //MARK:- Upload Image API Interaction
    func uploadImage(_ parameters:[String:AnyObject],parametersImage:[UIImage],videoUrl:URL?,addImageUrl:String, showIndicator: Bool,methodType: HTTPMethod, completion:@escaping(_ response: NSDictionary,_ responseAry: NSArray,_ isSuccess: Bool,_ message: String) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            if showIndicator {
                //Proxy.shared.showActivityIndicator()
            }
            debugPrint("URL: ",addImageUrl)
            debugPrint("Params: ", parameters)
            debugPrint("Params Image: ", parametersImage)
            debugPrint("Header: ", headers())
            AF.upload(multipartFormData: { multipartFormData in
                for (key, val) in parameters {
                    multipartFormData.append(val.data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
                for i in 0..<parametersImage.count {
                    let timeStamp = Date().timeIntervalSince1970 * 1000
                    guard let imageData = parametersImage[i].jpegData(compressionQuality: 0.5) else {
                        return
                    }
                    multipartFormData.append(imageData, withName: "attachments[]", fileName: "image\(timeStamp).jpeg", mimeType: "image/jpeg")
                }
                
                if videoUrl != nil {
                    
                    let videoFileName = "video\(Date().timeIntervalSince1970 * 1000).mp4"
                    multipartFormData.append(videoUrl!, withName: "Post[image_file]", fileName: videoFileName, mimeType: "video/mp4")
                }
            },to: addImageUrl,method: methodType, headers: HTTPHeaders(headers())).responseJSON { response in
                if response.data != nil && response.error == nil {
                   // Proxy.shared.hideActivityIndicator()
                    if let JSON = response.value as? NSDictionary {
                        debugPrint("JSON", JSON)
                        if response.response?.statusCode == 200 {
                            if let JSON = response.value as? NSDictionary{
                                debugPrint("JSON", JSON)
                                completion(JSON,[],true,"")
                            }
                            if let jsonAry = response.value as? NSArray{
                                debugPrint("JSONArry:", jsonAry)
                                completion(response.value as? NSDictionary ?? [:],jsonAry,true,"")
                            }
                        } else {
                            if response.response?.statusCode == 400{
                                completion(JSON,[],false,"")
                            } else if let JSON = response.value as? NSDictionary{
                                if response.response?.statusCode == 401 {
                                    let errorMsg = JSON["error"] as? String ??  JSON["message"] as? String ?? AppAlerts.titleValue.error
                                    Proxy.shared.displayStatusCodeAlert(errorMsg)
                                } else if response.response?.statusCode == 426 {
                                    let errorMsg = JSON["error"] as? String ??  JSON["message"] as? String ?? AppAlerts.titleValue.error
                                    Proxy.shared.displayStatusCodeAlert(errorMsg)
                                }
                            }
                        //    Proxy.shared.hideActivityIndicator()
                            if response.data != nil {
                                debugPrint(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!)
                            }
                            self.statusHandler(response.response, data: response.data, error: response.error as NSError?)
                        }
                    } else {
                       // Proxy.shared.hideActivityIndicator()
                        Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.ErrorUnabletoencodeJSONResponse)
                        if response.data != nil {
                            debugPrint(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? AppAlerts.titleValue.error)
                        }
                    }
                } else {
                   // Proxy.shared.hideActivityIndicator()
                    if response.data != nil {
                        debugPrint(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!)
                    }
                    self.statusHandler(response.response, data: response.data, error: response.error as NSError?)
                }
            }
        } else {
          //  Proxy.shared.hideActivityIndicator()
            Proxy.shared.openSettingApp()
        }
    }
    
    //MARK:- Error Handling Methos
    func statusHandler(_ response:HTTPURLResponse? , data:Data?, error:NSError?) {
        if let code = response?.statusCode {
            var messageStr = String()
            if data != nil {
                messageStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
                messageStr = messageStr == "" ? AppAlerts.titleValue.serverNotResponding : messageStr
            } else {
                messageStr = AppAlerts.titleValue.serverNotResponding
            }
            switch code {
            case 400:
                Proxy.shared.displayStatusCodeAlert(messageStr)
            case 403,401:
                Proxy.shared.displayStatusCodeAlert(messageStr)
            case 404:
                Proxy.shared.displayStatusCodeAlert(messageStr)
            case 500:
                Proxy.shared.displayStatusCodeAlert(messageStr)
            case 408:
                Proxy.shared.displayStatusCodeAlert(messageStr)
            case 426:
                Proxy.shared.displayStatusCodeAlert(messageStr)
            default:
                Proxy.shared.displayStatusCodeAlert(messageStr)
            }
        } else {
            if data != nil {
                let myHTMLString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
                if myHTMLString == "" {
                    Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.serverNotResponding)
                } else {
                    Proxy.shared.displayStatusCodeAlert(myHTMLString as String)
                }
            } else {
                Proxy.shared.displayStatusCodeAlert(AppAlerts.titleValue.serverNotResponding)
            }
        }
    }
}

