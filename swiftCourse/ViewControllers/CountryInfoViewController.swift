//
//  CountriesViewController.swift
//  swiftCourse
//
//  Created by user on 29.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CountryInfoViewController: UIViewController {
    
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var countryName: UILabel!
    
    private let country = DataStorage.shared.countryDidReceive()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countryName.text = country.name
        capital.text = country.capital
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
