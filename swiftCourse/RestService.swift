//
//  RestService.swift
//  swiftCourse
//
//  Created by user on 07.04.2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
class RestService {
    static let shared = RestService()
    private init() {}
    func requestCountry(completion: @escaping (Country)->()) {
        let urlString = "https://htmlweb.ru/geo/api.php?area=41&level=3&json&api_key=4c714b1d9ff48db1044b47da7b672035"
        let myUrl = URL(string: urlString)
        guard let url = myUrl else{
            print("URL Error")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                print("no error")
                if let data = data {
                    print("Data")
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]{
                            var cities = [City]()
                            for object in json.values {
                                if let cityDict = object as? [String: Any] {
                                    let id = cityDict["id"] as! Int
                                    let name = cityDict["name"] as! String
                                    let city = City(name: name, id: String(id))
                                    cities.append(city)
                                }
                            }
                            guard cities.count > 0 else {
                                return
                            }
                            let country = Country(id: "Ru", name: "Russia", capital: cities.first?.name, cities: cities)
                            completion(country)
                        }
                    }   catch{
                        print("error JSONSerialization")
                    }
                } else {
                    print("No data")
                }
            } else {
                print("error")
            }
        }
        task.resume()
    }
}
