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
    var user: User! {
        didSet{
            print("Set")
        }
        /*get {
            let name = defaults.string(forKey: kUserName)
            let birthDay = defaults.object(forKey: kUserBirthDay) as? Date
            var imageAvatar: UIImage? = nil
            if let dataAvatar = self.defaults.object(forKey: self.kUserDataAvatar) as? Data {
                imageAvatar = UIImage(data: dataAvatar)
            }
            let user = User(name: name, birthDay: birthDay, avatar: imageAvatar)
            DispatchQueue.main.async {
                self.user = user
                completion(user)
            }
        }
    }
    func updateUser(for user: User){
        defaults.set(user.name, forKey: kUserName)
        defaults.set(user.birthDay, forKey: kUserBirthDay)
                if let avatar = user.avatar {
                    DispatchQueue.global().async {
                        let dataAvatar = UIImagePNGRepresentation(avatar)
                        self.defaults.set(dataAvatar, forKey: self.kUserDataAvatar)
                }
            }
            delegate?.cityFavouriteChanged()
        }*/
    }
    func getUser(completion: @escaping (User)->()) {
        DispatchQueue.global().async {
            let name = self.defaults.string(forKey: self.kUserName)
            let birthDay = self.defaults.object(forKey: self.kUserBirthDay) as? Date
            var imageAvatar: UIImage? = nil
            if let dataAvatar = self.defaults.object(forKey: self.kUserDataAvatar) as? Data {
                imageAvatar = UIImage(data: dataAvatar)
            }
            let user = User(name: name, birthDay: birthDay, avatar: imageAvatar)
            DispatchQueue.main.async {
                self.user = user
                completion(user)
            }
        }
    }
    func setUser(for user: User) {
        defaults.set(user.name, forKey: kUserName)
        defaults.set(user.birthDay, forKey: kUserBirthDay)
        if let avatar = user.avatar {
            let dataAvatar = UIImagePNGRepresentation(avatar)
            defaults.set(dataAvatar, forKey: kUserDataAvatar)
        }
    }
}
protocol UserManagerDelegate: class {
    func uiDidChange()
}
