//
//  User.swift
//  swiftCourse
//
//  Created by user on 22.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Foundation

struct User {
    var name: String?
    var birthday: Date?
    var avatar: UIImage?
}

class UserManager {    
    private let defaults = UserDefaults.standard
    private let user = User()
    let kUserName = "userNameKey"
    let kUserBirthDay = "userBirthDayKey"
    let kUserDataAvatar = "keyAvatar"
    
    internal func getCurrentUser() -> User {
        let name = defaults.string(forKey: kUserName)
        let birthday = defaults.object(forKey: kUserBirthDay) as? Date
        var imageAvatar: UIImage? = nil
        if let dataAvatar = defaults.object(forKey: kUserDataAvatar) as? Data {
            imageAvatar = UIImage(data: dataAvatar)
        }
        let user = User(name: name, birthday: birthday, avatar: imageAvatar)
        
        return user
    }
    
    internal func change(user: User) {
        defaults.set(user.name, forKey: kUserName)
        defaults.set(user.birthday, forKey: kUserBirthDay)
        if let avatar = user.avatar {
            let dataAvatar = UIImagePNGRepresentation(avatar)
            defaults.set(dataAvatar, forKey: kUserDataAvatar)
        }
    }
}
