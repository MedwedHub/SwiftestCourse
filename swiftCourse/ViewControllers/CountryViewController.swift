//
//  CountryViewController.swift
//  swiftCourse
//
//  Created by user on 31.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    @IBOutlet weak var segmentedState: UISegmentedControl!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var citiesView: UIView!
    
    /*enum State: Int {
        case country = 0
        case cities = 1
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(0)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentedSwitch(_ sender: Any) {
        updateUI(segmentedState.selectedSegmentIndex)
    }
    
    fileprivate func updateUI(_ state: Int){
        switch state {
        case 0:
            countryView.isHidden = false
            citiesView.isHidden = true
        case 1:
            countryView.isHidden = true
            citiesView.isHidden = false
        default:
            print("SegmentedSwitch error")
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
