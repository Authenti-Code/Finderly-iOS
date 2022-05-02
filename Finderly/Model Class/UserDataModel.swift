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
class SponsoreModel {
    var created_at,image,updated_at,url,id,urlLink: String?
    var is_liked: Int?
    func sponsored(dataDict: NSDictionary){
        created_at = dataDict["created_at"] as? String ?? ""
        image = dataDict["image"] as? String ?? ""
        updated_at = dataDict["updated_at"] as? String ?? ""
        url = dataDict["url"] as? String ?? ""
        id = dataDict["id"] as? String ?? "0"
        urlLink = dataDict["url"] as? String ?? ""
    }
}
class TodaysRecommendModel {
    var image,businessName,phoneNumber,location,id,description,ratings: String?
    var categoryId,is_liked,ratings_count: Int?
    func businessData(dataDict: NSDictionary){
        image = dataDict["business_image"] as? String ?? ""
        businessName = dataDict["business_name"] as? String ?? ""
        phoneNumber = dataDict["phone_number"] as? String ?? ""
        location = dataDict["location"] as? String ?? ""
        id = dataDict["id"] as? String ?? "0"
        categoryId = dataDict["category_id"] as? Int ?? 0
        is_liked = dataDict["is_liked"] as? Int ?? 0
        description = dataDict["description"] as? String ?? "0"
        ratings = dataDict["ratings"] as? String ?? "0"
        ratings_count = dataDict["ratings_count"] as? Int ?? 0
    }
}
class Top10BusinessModel {
    var image,businessName,phoneNumber,location,id,description,ratings: String?
    var categoryId,is_liked,ratings_count: Int?
    func businessData(dataDict: NSDictionary){
        image = dataDict["business_image"] as? String ?? ""
        businessName = dataDict["business_name"] as? String ?? ""
        phoneNumber = dataDict["phone_number"] as? String ?? ""
        location = dataDict["location"] as? String ?? ""
        id = dataDict["id"] as? String ?? "0"
        categoryId = dataDict["category_id"] as? Int ?? 0
        is_liked = dataDict["is_liked"] as? Int ?? 0
        description = dataDict["description"] as? String ?? "0"
        ratings = dataDict["ratings"] as? String ?? "0"
        ratings_count = dataDict["ratings_count"] as? Int ?? 0
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
    var name,imageIcon,phoneNumber,location,description,ratings,id: String?
    var categoryId,ratings_count,is_liked: Int?
    func resturanr(dataDict: NSDictionary){
        id = dataDict["id"] as? String ?? ""
        name = dataDict["business_name"] as? String ?? ""
        phoneNumber = dataDict["phone_number"] as? String ?? ""
        imageIcon = dataDict["business_image"] as? String ?? ""
        location = dataDict["location"] as? String ?? ""
        categoryId = dataDict["category_id"] as? Int ?? 0
        description = dataDict["description"] as? String ?? ""
        ratings = dataDict["ratings"] as? String ?? ""
        ratings_count = dataDict["ratings_count"] as? Int ?? 0
        is_liked = dataDict["is_liked"] as? Int ?? 0
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
    var phoneNumber,buisnessName,location,image,description,ratings,id: String?
    var category_id,is_liked,ratings_count: Int?
    func hooked(dataDict: NSDictionary){
        phoneNumber = dataDict["phone_number"] as? String ?? ""
        buisnessName = dataDict["business_name"] as? String ?? ""
        location = dataDict["location"] as? String ?? ""
        image = dataDict["business_image"] as? String ?? ""
        category_id = dataDict["category_id"] as? Int ?? 0
        id = dataDict["id"] as? String ?? ""
        description = dataDict["description"] as? String ?? ""
        ratings = dataDict["ratings"] as? String ?? ""
        is_liked = dataDict["is_liked"] as? Int ?? 0
        ratings_count = dataDict["ratings_count"] as? Int ?? 0
    }
}
class BuisnessDetailModel{
    var business_logo,buisnessName,location,created_at,description,email,first_name,last_name,ratings: String?
    var id,category_id: Int?
    func detail(dataDict: NSDictionary){
        business_logo = dataDict["business_logo"] as? String ?? ""
        buisnessName = dataDict["buisnessName"] as? String ?? ""
        print("buisnessName",buisnessName)
        location = dataDict["location"] as? String ?? ""
        created_at = dataDict["created_at"] as? String ?? ""
        description = dataDict["description"] as? String ?? ""
        category_id = dataDict["category_id"] as? Int ?? 0
        id = dataDict["id"] as? Int ?? 0
        ratings = dataDict["ratings"] as? String ?? ""
    }
}
class BusinessImagesModel{
    var business_images: String?
    func bImage(dataDict: NSDictionary){
        business_images = dataDict["business_images"] as? String ?? ""
    }
}
class specializationsModel{
    var category,created_at,id,name,updated_at: String?
    func speciliza(dataDict: NSDictionary){
        category = dataDict["category"] as? String ?? ""
        created_at = dataDict["created_at"] as? String ?? ""
        id = dataDict["id"] as? String ?? ""
        name = dataDict["name"] as? String ?? ""
        updated_at = dataDict["updated_at"] as? String ?? ""
    }
}
