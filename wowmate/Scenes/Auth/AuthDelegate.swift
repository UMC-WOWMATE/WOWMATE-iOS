//
//  AuthDelegate.swift
//  wowmate
//
//  Created by 김초원 on 2023/02/10.
//

import Foundation

protocol AuthDelegate: AnyObject {
    var inputUserInfo: [String:Any] { get  }
    
    func saveEmailPw(email: String, password: String)
    func saveUserInfo(birth: Date, gender: String, phoneNum: String)
}

class SignupDataManager: AuthDelegate {
    static let shared = SignupDataManager()
    
    var inputUserInfo: [String : Any] = [:]

    func saveEmailPw(email: String, password: String) {
        inputUserInfo["email"] = email
        inputUserInfo["password"] = password
        
        print("inputUserInfo['email'] : \(inputUserInfo["email"]!)")
        print("inputUserInfo['password'] : \(inputUserInfo["password"]!)")
    }
    
    func saveUserInfo(birth: Date, gender: String, phoneNum: String) {
        inputUserInfo["birth"] = birth
        inputUserInfo["gender"] = gender
        inputUserInfo["phoneNumber"] = phoneNum
        
        print("inputUserInfo['birth'] : \(inputUserInfo["birth"]!)")
        print("inputUserInfo['gender'] : \(inputUserInfo["gender"]!)")
        print("inputUserInfo['phoneNumber'] : \(inputUserInfo["phoneNumber"]!)")
    }
}
