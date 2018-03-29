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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DataCity.shared.appendCity()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCity.shared.cities.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CustomTableViewCell
        let city = DataCity.shared.cities[indexPath.row]
        let favourite = DataCity.shared.isFavourite(city: city)
        cell.cityLabel.text = "\(city.name)" + " with \(city.id)"
        cell.cityImageFav.image = UIImage(named: "Star_on")
        if !favourite {
            cell.cityImageFav.isHidden = true
        } else {
            cell.cityImageFav.isHidden = false
        }
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cityVC: CityViewController? = segue.destination as? CityViewController
        let indexPath = tableView.indexPathForSelectedRow
        let city = DataCity.shared.cities[indexPath!.row]
        cityVC?.city = city
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
