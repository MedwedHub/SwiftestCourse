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
    
    internal func getCurrentUser() -> User {
        let name = UserDefaults.standard.string(forKey: "userNameKey")
        let birthday = UserDefaults.standard.object(forKey: "userBirthdayKey") as? Date
        let user = User(name: name, birthday: birthday, avatar: nil)
        
        return user
    }
    
    internal func change(user: User) {
        UserDefaults.standard.set(user.name, forKey: "userNameKey")
        UserDefaults.standard.set(user.birthday, forKey: "userBirthdayKey")
    }
}
