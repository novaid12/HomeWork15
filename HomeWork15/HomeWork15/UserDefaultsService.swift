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
}

// extension Employee: Codable {}
//
//// создадим кодировщик в jsonData
// let jsonEncoder = JSONEncoder()
//
//// создадим дешифровщик в нашу модель
// let jsonDecoder = JSONDecoder()
// if let data = data,
//   let someEmployee = try? jsonDecoder.decode(Employee.self, from: data)
// {
//    print(someEmployee)
// }
