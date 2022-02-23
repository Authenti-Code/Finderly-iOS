//
//  UserDataModel.swift
//  Finderly
//
//  Created by Pankush Mehra on 10/02/22.
//

import Foundation
class UserDataModel {
    var userName,phoneNumber,email,password,confirmPassword : String?
    var otp,userId: Int?
    var fromSignUp :Bool?
    func userInfo(dataDict: NSDictionary){
        otp = dataDict["otp"] as? Int
        userId = dataDict["id"] as? Int
        email = dataDict["email"] as? String ?? ""
        if fromSignUp == true{
            accessToken = dataDict["token"] as? String ?? ""
        } else{
            if accessToken == "" {
                accessToken = dataDict["token"] as? String ?? ""
            }
        }
    }
}
class HomeDataBusinessModel {
    var image,businessName,phoneNumber,location: String?
    var id,categoryId: Int?
    func businessData(dataDict: NSDictionary){
        image = dataDict["business_image"] as? String ?? ""
        businessName = dataDict["business_name"] as? String ?? ""
        phoneNumber = dataDict["phone_number"] as? String ?? ""
        location = dataDict["location"] as? String ?? ""
        id = dataDict["id"] as? Int ?? 0
        categoryId = dataDict["category_id"] as? Int ?? 0
    }
}
class BannerModel{
    var bannerImage: String?
    var id: Int?
    
    func bannerData(dataDict: NSDictionary){
        id = dataDict["id"] as? Int ?? 0
        bannerImage = dataDict["banner"] as? String ?? ""
        print("Image:--->",bannerImage as Any)
    }
}
class CategoryModel{
    var name,imageIcon,status: String?
    var id: Int?
    func categoryData(dataDict: NSDictionary){
        name = dataDict["name"] as? String ?? ""
        imageIcon = dataDict["icon"] as? String ?? ""
        status = dataDict[""] as? String ?? ""
        id = dataDict["id"] as? Int ?? 0
    }
}
class ResturantModel{
    var name,imageIcon,phoneNumber,location: String?
    var id,categoryId: Int?
    func resturanr(dataDict: NSDictionary){
        id = dataDict["id"] as? Int ?? 0
        name = dataDict["business_name"] as? String ?? ""
        phoneNumber = dataDict["phone_number"] as? String ?? ""
        imageIcon = dataDict["business_icon"] as? String ?? ""
        location = dataDict["location"] as? String ?? ""
        categoryId = dataDict["category_id"] as? Int ?? 0
        
        
    }
}
class NotificationModel{
    var title,discription,time: String?
    var id: Int?
    func notificationDict(dataDict: NSDictionary){
        title = dataDict["title"] as? String ?? ""
        discription = dataDict["description"] as? String ?? ""
        time = dataDict["time"] as? String ?? ""
        id = dataDict["id"] as? Int ?? 0
    }
}
