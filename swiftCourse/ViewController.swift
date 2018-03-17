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
        
        Data.shared.appendCity()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.shared.cities.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        let city = Data.shared.cities[indexPath.row]
        cell.textLabel?.text = "\(city.name)" + " with \(city.id)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cityVC: CityViewController? = segue.destination as? CityViewController
        
        let indexPath = tableView.indexPathForSelectedRow
        let city = Data.shared.cities[indexPath!.row]
        
        cityVC?.city = city
    }
}

