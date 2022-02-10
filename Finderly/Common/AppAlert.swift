//
//  AppAlerts.swift
//   DigiImpact
//
//  Created by desh raj thakur on 03/09/20.
//  Copyright © 2020 Swift Developers. All rights reserved.
//

import UIKit

class AppAlerts {
    static var titleValue: AppAlerts {
        return AppAlerts()
    }
    fileprivate init(){}
    
    //MARK:- App Common Titles
    var chooseImage = "Choose Image"
    var camrea = "Camera"
    var ok = "Ok"
    var cancel = "Cancel"
    var camera = "Camera"
    var gallery = "Gallery"
    var cameraNotsupported = "Camera is not supported"
    var connectionProblem = "Connection Problem"
    var setting = "Setting"
    var locationProblem = "Location Problem"
    var error = "Error!"
    var ago = "ago"
    var year = "year"
    var years = "years"
    var month = "month"
    var months = "months"
    var day = "day"
    var days = "days"
    var hour = "hour"
    var hours = "hours"
    var alert = "Alert"
    var minute = "minute"
    var minutes = "minutes"
    var second = "second"
    var seconds = "seconds"
    var aMoment = "a moment"
    var newPresent = "New Preset"
    
    //MARK:- App Common Alerts
    var pleaseReviewyournetworksettings = "Please Review your network settings"
    var checkInternet = "Please check your internet connection"
    var enableLocation = "Please enable your location"
    var ErrorUnabletoencodeJSONResponse = "Error: Unable to encode JSON Response"
    var serverError = "Server error, Please try again.."
    var serverNotResponding = "Server not responding"
    var validLink = "This url is not valid"
    var passwordLength = "Please set minimum 8 character password"
    var cameraPermissionAlert = "Grit doesn't have permission to use the camera, please change privacy settings"
    var galleryPermissionAlert = "Please check to see if device settings doesn't allow photo library access"
    var locationServicesDetermine = "Location Services are not able to determine your location"
    
    var userError = "User not found"
    var addContext = "Please enter context"
    var addRelationship = "Please enter relation"
    var relationSuccess = "Relation added success"
    var contextSuccess = "Context added success"
    var otp = "Please enter OTP that you have recevied in your mail"
    
    var usernameMail        =  "Please enter your email"
    var oldPassword         =  "Please enter old password"
    var password            =  "Please enter password"
    var newpassword         =  "Please enter new password"
    var validName           =  "Please enter valid name"
    var firstName           =  "Please enter first name"
    var lastName            =  "Please enter last name"
    var fullName            =  "Please enter your name"
    var companyName         =  "Please enter your company name"
    var email               =  "Please enter email"
    var startDate           =  "Please enter start date"
    var endDate             =  "Please enter end date"
    var job                 =  "Please enter your job"
  
    var validOtp            =  "Please enter valid OTP"
    var otpVerified         =  "OTP verified success"
    var otpMismatch         =  "OTP is incorrect"
    
    var phoneNumber         = "Please enter phone number"
    var validPassword       = "Password should have minimum 8 alphanumeric characters with atleast one special character"
    var confirmPassword     = "Please enter confirm password"
    var samePassword        = "Password does not match"
    var validEmail          = "Please enter valid email"
    var DOB                 = "Please select date of birth"
    var gender              = "Please select gender"
    var zipcode             = "Please enter zipcode"
    var privacyPolicy       = "Please select privacy policy"
    var logoutMessage       = "Are you sure you want to logout?"
    var loginFailed         = "Please enter valid credentials"
}
