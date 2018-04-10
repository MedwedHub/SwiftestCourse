//
//  CityViewController.swift
//  swiftCourse
//
//  Created by user on 17.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CityViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    internal var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = city.name
        updateUI()
        print("UI has been loaded")
        DataStorage.shared.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        let favourite = DataStorage.shared.isFavourite(city: city)
        print("Will appear")
        updateUI(for: favourite)
        
    }
    @IBAction func pressButton(_ sender: Any) {
        DataStorage.shared.changeFavourite(for: city)
    }
    private func updateUI() {
        let favourite = DataStorage.shared.isFavourite(city: city)
        updateUI(for: favourite)
    }
    private func updateUI(for favourite: Bool) {
        let image: UIImage
        image = favourite ? UIImage(named: "Star_on")! : UIImage(named: "Star_off")!
        print(favourite)
        navigationItem.rightBarButtonItem?.image = image
    }
    
}
extension CityViewController: DataStorageDelegate {
    func cityFavouriteChanged(_ city: City, _ favourite: Bool) {
        if city.name == self.city.name {
            updateUI(for: favourite)
        }
    }
}
