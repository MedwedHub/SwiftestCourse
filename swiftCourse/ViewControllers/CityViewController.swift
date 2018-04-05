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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    @IBAction func pressButton(_ sender: Any) {
        DataStorage.shared.changeFavourite(for: city)
        updateUI()
    }
    private func updateUI() {
        let favorite = DataStorage.shared.isFavourite(city: city)
        let image: UIImage
        
        if favorite {
            image = UIImage(named: "Star_on")!
        } else {
            image = UIImage(named: "Star_off")!
        }
        navigationItem.rightBarButtonItem?.image = image
    }
}
