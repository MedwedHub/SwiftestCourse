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
    var country: Country?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DataStorage.shared.delegat = self
        print("TableView has been loaded")
        country = DataStorage.shared.country
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.country = DataStorage.shared.countryDidReceive()
            self.tableView.reloadData()
        }*/
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return country?.cities!.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CustomTableViewCell
        let city = country?.cities![indexPath.row]
        let favourite = DataStorage.shared.isFavourite(city: city!)
        //cell.cityLabel.text = "\(city!.name)" + " id: \(city!.id)"
        cell.cityLabel.text = "\(city!.name)"
        cell.cityImageFav.image = UIImage(named: "Star_on")
        cell.cityImageFav.isHidden = !favourite ? true : false
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cityVC: CityViewController? = segue.destination as? CityViewController
        let indexPath = tableView.indexPathForSelectedRow
        let city = country?.cities![indexPath!.row]
        cityVC?.city = city
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
extension ViewController: TableViewAlert {
    func updateUI() {
        DispatchQueue.main.async {
            self.country = DataStorage.shared.country
            self.tableView.reloadData()
            print("TableView was reloaded!")
        }
    }
}
