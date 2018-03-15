//
//  Data.swift
//  swiftCourse
//
//  Created by user on 15.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class Data {
    static let shared = Data()
    
    private init() {}
    
    internal var cities = [City]()
    
    internal func appending() {
        for i in 0..<50 {
            cities.append(City(name: "City \(i)", id: " id = \(i)"))
        }
    }
    
}
