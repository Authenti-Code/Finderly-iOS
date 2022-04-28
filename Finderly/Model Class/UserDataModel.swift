//
//  UserDataModel.swift
//  Finderly
//
//  Created by Pankush Mehra on 10/02/22.
//

import Foundation
class UserDataModel {
    var userName,phoneNumber,email,password,confirmPassword,userProfile : String?
    var otp,userId: Int?
    var fromSignUp :Bool?
    func userInfo(dataDict: NSDictionary){
        otp = dataDict["otp"] as? Int
        userId = dataDict["id"] as? Int
        email = dataDict["email"] as? String ?? ""
        userName = dataDict["user_name"] as? String ?? ""
        phoneNumber = dataDict["mobile_number"] as? String ?? ""
        userProfile = dataDict["user_profile"] as? String ?? ""
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
class IndividualModel {
    var image,businessName,phoneNumber,location,id,description: String?
    var categoryId,is_liked: Int?
    func businessData(dataDict: NSDictionary){
        image = dataDict["business_image"] as? String ?? ""
        businessName = dataDict["business_name"] as? String ?? ""
        phoneNumber = dataDict["phone_number"] as? String ?? ""
        location = dataDict["location"] as? String ?? ""
        id = dataDict["id"] as? String ?? "0"
        categoryId = dataDict["category_id"] as? Int ?? 0
        is_liked = dataDict["is_liked"] as? Int ?? 0
        description = dataDict["description"] as? String ?? "0"
    }
}
class TodaysRecommendModel {
    var image,businessName,phoneNumber,location,id,description: String?
    var categoryId,is_liked: Int?
    func businessData(dataDict: NSDictionary){
        image = dataDict["business_image"] as? String ?? ""
        businessName = dataDict["business_name"] as? String ?? ""
        phoneNumber = dataDict["phone_number"] as? String ?? ""
        location = dataDict["location"] as? String ?? ""
        id = dataDict["id"] as? String ?? "0"
        categoryId = dataDict["category_id"] as? Int ?? 0
        is_liked = dataDict["is_liked"] as? Int ?? 0
        description = dataDict["description"] as? String ?? "0"
    }
}
class Top10BusinessModel {
    var image,businessName,phoneNumber,location,id,description: String?
    var categoryId,is_liked: Int?
    func businessData(dataDict: NSDictionary){
        image = dataDict["business_image"] as? String ?? ""
        businessName = dataDict["business_name"] as? String ?? ""
        phoneNumber = dataDict["phone_number"] as? String ?? ""
        location = dataDict["location"] as? String ?? ""
        id = dataDict["id"] as? String ?? "0"
        categoryId = dataDict["category_id"] as? Int ?? 0
        is_liked = dataDict["is_liked"] as? Int ?? 0
        description = dataDict["description"] as? String ?? "0"
    }
}
class BannerModel{
    var bannerImage: String?
    var id: Int?
    
    func bannerData(dataDict: NSDictionary){
        id = dataDict["id"] as? Int ?? 0
        bannerImage = dataDict["banner"] as? String ?? ""
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
        imageIcon = dataDict["business_image"] as? String ?? ""
        location = dataDict["location"] as? String ?? ""
        print("Location",location as Any)
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
class BuisnessHookedModel{
    var phoneNumber,buisnessName,location,image: String?
    var id,category_id: Int?
    func hooked(dataDict: NSDictionary){
        phoneNumber = dataDict["phone_number"] as? String ?? ""
        buisnessName = dataDict["business_name"] as? String ?? ""
        location = dataDict["location"] as? String ?? ""
        image = dataDict["business_image"] as? String ?? ""
        category_id = dataDict["category_id"] as? Int ?? 0
        id = dataDict["id"] as? Int ?? 0
    }
}
class BuisnessDetailModel{
    var business_logo,buisnessName,location,created_at,description,email,first_name,last_name: String?
    var id,category_id: Int?
    func detail(dataDict: NSDictionary){
        business_logo = dataDict["business_logo"] as? String ?? ""
        buisnessName = dataDict["buisnessName"] as? String ?? ""
        location = dataDict["location"] as? String ?? ""
        created_at = dataDict["created_at"] as? String ?? ""
        description = dataDict["description"] as? String ?? ""
        category_id = dataDict["category_id"] as? Int ?? 0
        id = dataDict["id"] as? Int ?? 0
    }
    
}
