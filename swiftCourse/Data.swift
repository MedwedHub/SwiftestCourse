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
    private var favouriteCities = [City]()
    
    internal func appendCity() {
        
        for i in 0..<50 {
            cities.append(City(name: "City \(i)", id: " id = \(UUID().uuidString)"))
        }
    }
    
    internal func isFavourite(city: City) -> Bool {
        
        for favorite in favouriteCities {
            if favorite.id == city.id {
                return true
            }
        }
        return false
    }
    internal func changeFavourite(for city: City){
        
        let exist = isFavourite(city: city)
        if exist {
            removeCity(city: city)            
        } else {
            favouriteCities.append(city)
        }
    }
    internal func removeCity(city: City) {
        
        for favourite in favouriteCities {
            if favourite.id == city.id{
                if let position = favouriteCities.index(where: { $0.id == city.id}) {
                    favouriteCities.remove(at: position)
                }
            }
        }
    }
}

