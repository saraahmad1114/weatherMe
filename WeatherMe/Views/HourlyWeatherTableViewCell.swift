//
//  HourlyWeatherTableViewCell.swift
//  WeatherMe
//
//  Created by Sara Ahmad on 3/7/18.
//
//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.
//

import UIKit

class HourlyWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var hourlyTimeLabel: UILabel!
    @IBOutlet weak var hourlyIconImage: UIImageView!
    @IBOutlet weak var hourlyTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
