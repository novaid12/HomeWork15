//
//  UserDefaultsService.swift
//  HomeWork15
//
//  Created by  NovA on 30.08.23.
//

import Foundation

final class UserDefaultsService {
    static func saveUserModel(userModel: UserModel) {
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(userModel) else { return }
        UserDefaults.standard.set(jsonData, forKey: userModel.email)
    }

    static func getUserModel(email: String, pass: String) -> UserModel? {
        let jsonDecoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: email),
           let userModel = try? jsonDecoder.decode(UserModel.self, from: data),
           pass == userModel.pass
        {
            UserDefaults.standard.set(email, forKey: "authorization")
            return userModel
        } else { return nil }
    }

    static func cleanUserDefauts(email: String) {
        UserDefaults.standard.reset(email: email)
    }

    static func authorizationUser() -> UserModel? {
        return UserDefaults.standard.authorization()
    }

    static func editUserModel(userModelOld: UserModel, userModelNew: UserModel) -> UserModel? {
        var name: String?
        var email: String
        var pass: String
        if userModelOld.name != userModelNew.name {
            name = userModelNew.name
        } else if userModelNew.name == "" {
            name = "Unknown"
        } else { name = userModelOld.name }
        if userModelOld.email != userModelNew.email {
            email = userModelNew.email
        } else { email = userModelOld.email }
        if userModelOld.pass != userModelNew.pass, userModelNew.pass != "" {
            pass = userModelNew.pass
        } else { pass = userModelOld.pass }
        UserDefaults.standard.removeObject(forKey: email)
        UserDefaults.standard.removeObject(forKey: "authorization")
        saveUserModel(userModel: UserModel(name: name, email: email, pass: pass))
        UserDefaults.standard.set(email, forKey: "authorization")
        return UserModel(name: name, email: email, pass: pass)
    }
}
