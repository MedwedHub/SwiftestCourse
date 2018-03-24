//
//  User.swift
//  swiftCourse
//
//  Created by user on 22.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

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
        let name = UserDefaults.standard.string(forKey: kUserName)
        let birthday = UserDefaults.standard.object(forKey: kUserBirthDay) as? Date
        var imageAvatar: UIImage? = nil
        if let dataAvatar = UserDefaults.standard.object(forKey: kUserDataAvatar) as? Data {
            imageAvatar = UIImage(data: dataAvatar)
        }
        let user = User(name: name, birthday: birthday, avatar: imageAvatar)
        
        return user
    }
    
    internal func change(user: User) {
        UserDefaults.standard.set(user.name, forKey: kUserName)
        UserDefaults.standard.set(user.birthday, forKey: kUserBirthDay)
        if let avatar = user.avatar {
            let dataAvatar = UIImagePNGRepresentation(avatar)
            UserDefaults.standard.set(dataAvatar, forKey: kUserDataAvatar)
        }
    }
}
