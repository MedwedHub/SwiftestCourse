//
//  FavCustomTableViewCell.swift
//  swiftCourse
//
//  Created by Евгений Бойко on 05.04.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class FavCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favCityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
