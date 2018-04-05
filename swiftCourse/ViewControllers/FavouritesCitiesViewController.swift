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
    //@IBOutlet weak var favTableView: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.shared.favouriteCities.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTableView.dequeueReusableCell(withIdentifier: "FavCityCell", for: indexPath) as! FavCustomTableViewCell
        let favCity = DataStorage.shared.favouriteCities[indexPath.row]
        //cell.favCityLabel.text = "\(favCity.name)" + " with \(favCity.id)"
        cell.favCityLabel.text = "\(favCity.name)" + "\(favCity.id)"
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
 }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let favCity = DataStorage.shared.favouriteCities[indexPath.row]
        DataStorage.shared.removeCity(city: favCity)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cityVC = segue.destination as? CityViewController
        let indexPath = favTableView.indexPathForSelectedRow
        let city = DataStorage.shared.favouriteCities[indexPath!.row]
        cityVC?.city = city
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        favTableView.reloadData()
    }
}
