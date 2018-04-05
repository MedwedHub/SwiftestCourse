//
//  UserManager.swift
//  swiftCourse
//
//  Created by user on 29.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Foundation

class UserManager {
    private let defaults = UserDefaults.standard
    private let kUserName = "userNameKey"
    private let kUserBirthDay = "userBirthDayKey"
    private let kUserDataAvatar = "keyAvatar"
    weak var delegate: UserManagerDelegate?
    var user: User {
        get {
            let name = defaults.string(forKey: kUserName)
            let birthDay = defaults.object(forKey: kUserBirthDay) as? Date
            var imageAvatar: UIImage? = nil
            if let dataAvatar = defaults.object(forKey: kUserDataAvatar) as? Data {
                imageAvatar = UIImage(data: dataAvatar)
            }
            let user = User(name: name, birthDay: birthDay, avatar: imageAvatar)
            return user
        }
        set {
            defaults.set(newValue.name, forKey: kUserName)
            defaults.set(newValue.birthDay, forKey: kUserBirthDay)
            if let avatar = newValue.avatar {
                let dataAvatar = UIImagePNGRepresentation(avatar)
                defaults.set(dataAvatar, forKey: kUserDataAvatar)
            }
            delegate?.cityFavouriteChanged()
        }
    }
}
protocol UserManagerDelegate: class {
    func cityFavouriteChanged()
}
