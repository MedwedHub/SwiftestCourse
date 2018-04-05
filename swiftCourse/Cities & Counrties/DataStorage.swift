//
//  Data.swift
//  swiftCourse
//
//  Created by user on 15.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class DataStorage {
    weak var delegate: DataStorageDelegate?
    static let shared = DataStorage()
    private init() {}
    
    var country: Country?
    //private var favouriteCities = [City]()
    var favouriteCities = [City]()
    
    fileprivate func appendCity() -> [City] {
        var cities = [City]()
        let rand = arc4random_uniform(50) + 5
        for i in 0..<rand {
           // cities.append(City(name: "City \(i)", id: " id = \(UUID().uuidString)"))
            cities.append(City(name: "City \(i) with id: ", id: "\(i)"))
        }
        return cities
    }
    internal func getCountry() -> Country {
        if let c = country {
            return c
        } else {
            let id = UUID().uuidString
            let cities = appendCity()
            let capital = cities.first!
            let c = Country(id: id, name: "Uganda", capital: capital.name + " \(capital.id)", cities: cities)
            return c
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
        delegate?.cityFavouriteChanged(city, exist)
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
protocol DataStorageDelegate: class {
    func cityFavouriteChanged(_ city: City, _ favourite: Bool)
}
