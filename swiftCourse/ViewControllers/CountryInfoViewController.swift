//
//  CountryInfoViewController.swift
//  swiftCourse
//
//  Created by user on 29.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

/*import Foundation

enum ShowState: Int {
    case countryInfo = 0
    case cities = 1
}
citiesContainer: UIView!
countryIngoContainer: UIView!

private let country = DataCity.shared.getCounrty()

override func viewDidLoad() {
    super.viewDidLoad()
    let state = .cities
}
func prepare(){
    if ler citiesController = segue.destination as CitiesViewController
    citiesController.country = country
}

func segmentedAction (_ sender: UISegmentedControl) {
   let index = sender.selectedSegmaentIndex
   print(index)
    
    guard let state = ShowState(rawValue: index) else {
        assertionFailure("Segmention error")
        return
        
    }
    configureUI(for: state)
    /*switch index {
    case 0:
        citiesContainer.isHidden = true
        countryInfoContainer.isHidden = false
    case 1:
        citiesContainer.isHidden = true
        countryInfoContainer.isHidden = false
    default:
        print("error segmentedAction")
        assertionFailure("error segmentedAction")*/
    }
    fileprivate func configureUI(for state: ShowState) {
        switch state {
        case .countryInfo:
            citiesContainer.isHidden = true
            countryInfoContainer.isHidden = false
        case .cities:
            citiesContainer.isHidden = false
            countryInfoContainer.isHidden = true
        }
    }
}*/
