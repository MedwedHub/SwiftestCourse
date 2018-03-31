//
//  CountriesViewController.swift
//  swiftCourse
//
//  Created by user on 29.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var cityView: UIView!
    private let country = DataStorage.shared.getCountry()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
