//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by 細川聖矢 on 2019/06/15.
//  Copyright © 2019 Seiya. All rights reserved.
//

import UIKit


class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
