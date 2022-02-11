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
