//
//  ViewController.swift
//  swiftCourse
//
//  Created by user on 15.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    let country = DataStorage.shared.getCountry()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return country.cities!.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CustomTableViewCell
        let city = country.cities![indexPath.row]
        let favourite = DataStorage.shared.isFavourite(city: city)
        cell.cityLabel.text = "\(city.name)" + "\(city.id)"
        cell.cityImageFav.image = UIImage(named: "Star_on")
        cell.cityImageFav.isHidden = !favourite ? true : false
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cityVC: CityViewController? = segue.destination as? CityViewController
        let indexPath = tableView.indexPathForSelectedRow
        let city = country.cities![indexPath!.row]
        cityVC?.city = city
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

