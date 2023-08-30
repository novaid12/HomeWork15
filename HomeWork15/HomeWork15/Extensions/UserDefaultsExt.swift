//
//  UserDefaultsExt.swift
//  HomeWork15
//
//  Created by  NovA on 30.08.23.
//

import Foundation

extension UserDefaults {
    enum Keys: String, CaseIterable {
        case authorization
    }

    func reset(email: String) {
        UserDefaults.standard.removeObject(forKey: email)
    }

    func authorization() -> UserModel? {
        var newUserModel: UserModel?
        let allCases = Keys.allCases
        for _ in allCases {
            let jsonDecoder = JSONDecoder()
            guard let str = string(forKey: "authorization"),
                  let data = data(forKey: str),
                  let userModel = try? jsonDecoder.decode(UserModel.self, from: data) else { return nil }
            newUserModel = userModel
        }
        return newUserModel
    }
}
