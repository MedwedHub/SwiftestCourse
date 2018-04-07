//
//  FavouritesCitiesViewController.swift
//  swiftCourse
//
//  Created by user on 31.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class FavouritesCitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favTableView: UITableView!
    private var cities: [City]!
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
        loadCities()
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTableView.dequeueReusableCell(withIdentifier: "FavCityCell", for: indexPath) as! FavCustomTableViewCell
        let favCity = cities[indexPath.row]
        cell.favCityLabel.text = "\(favCity.name)" + "\(favCity.id)"
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
 }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        let favCity = cities[indexPath.row]
        DataStorage.shared.removeCity(city: favCity)
        cities.remove(at: indexPath.row)
        favTableView.deleteRows(at: [indexPath], with: .left)
    }
}
    private func loadCities() {
        cities = DataStorage.shared.favouriteCities.sorted(by: { (city1, city2) -> Bool in
            return Int(city1.id)! < Int(city2.id)!
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cityVC = segue.destination as? CityViewController
        let indexPath = favTableView.indexPathForSelectedRow
        let city = cities[indexPath!.row]
        cityVC?.city = city
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        loadCities()
        favTableView.reloadData()
    }
}
