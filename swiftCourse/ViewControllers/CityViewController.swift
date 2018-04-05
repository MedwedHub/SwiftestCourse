//
//  CityViewController.swift
//  swiftCourse
//
//  Created by user on 17.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    internal var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = city.name
        DataStorage.shared.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        let favourite = DataStorage.shared.isFavourite(city: city)
        updateUI(for: favourite)
    }
    @IBAction func pressButton(_ sender: Any) {
        DataStorage.shared.changeFavourite(for: city)
        //updateUI()
    }
    private func updateUI(for favourite: Bool) {
        //let favorite = DataStorage.shared.isFavourite(city: city)
        let image: UIImage
        image = favourite ? UIImage(named: "Star_on")! : UIImage(named: "Star_off")!
        /*if favorite {
            image = UIImage(named: "Star_on")!
        } else {
            image = UIImage(named: "Star_off")!
        }*/
        navigationItem.rightBarButtonItem?.image = image
    }
}
extension CityViewController: DataStorageDelegate {
    func cityFavouriteChanged(_ city: City, _ favourite: Bool) {
        if city.name == self.city.name {
            updateUI(for: !favourite)
        }
        DataStorage.shared.favouriteCities.sort { (city1, city2) -> Bool in
            return Int(city1.id)! < Int(city2.id)!
        }
    }
}
