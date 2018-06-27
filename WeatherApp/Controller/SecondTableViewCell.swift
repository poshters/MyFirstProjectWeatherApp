//
//  SecondTableViewCell.swift
//  WeatherApp
//
//  Created by mac on 6/27/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    @IBOutlet weak var secondDate: UILabel!
    @IBOutlet weak var secondDesc: UILabel!
    @IBOutlet weak var secondMax: UILabel!
    @IBOutlet weak var secondMin: UILabel!
    @IBOutlet weak var secondImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
