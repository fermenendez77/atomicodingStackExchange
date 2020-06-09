//
//  BadgesViewCell.swift
//  StackExchange
//
//  Created by Fernando Menendez on 05/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import UIKit

class BadgesViewCell: UITableViewCell {
    
    
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setBadge(type : Badgetype) {
        switch type {
            case .bronze:
                badgeImageView.tintColor = #colorLiteral(red: 0.4705882353, green: 0.3882352941, blue: 0.3137254902, alpha: 1)
            case .silver:
                badgeImageView.tintColor = #colorLiteral(red: 0.5450980392, green: 0.5490196078, blue: 0.5607843137, alpha: 1)
            case .gold:
                badgeImageView.tintColor = #colorLiteral(red: 0.6392156863, green: 0.5254901961, blue: 0.2470588235, alpha: 1)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
