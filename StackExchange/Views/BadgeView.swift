//
//  BadgeView.swift
//  StackExchange
//
//  Created by Fernando Menendez on 04/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import UIKit
import PureLayout

class BadgeView: UIView {
    
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var badgeCountLabel: UILabel!
    @IBOutlet weak var titleLabe: UILabel!
    
    var type : Badgetype?
    var badgeNumberLabel : UITextView!
    var numberOfBadges : Int = 0 {
        didSet {
            badgeCountLabel?.text = String(numberOfBadges)
        }
    }
    
    var color : (borderColor : UIColor, backgroundColor : UIColor) {
        switch type {
        case .bronze:
            return (#colorLiteral(red: 0.4705882353, green: 0.3882352941, blue: 0.3137254902, alpha: 1),#colorLiteral(red: 0.2941176471, green: 0.262745098, blue: 0.2352941176, alpha: 1))
        case .silver:
            return (#colorLiteral(red: 0.5450980392, green: 0.5490196078, blue: 0.5607843137, alpha: 1),#colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1))
        case .gold:
            return (#colorLiteral(red: 0.6392156863, green: 0.5254901961, blue: 0.2470588235, alpha: 1),#colorLiteral(red: 0.3607843137, green: 0.3294117647, blue: 0.007843137255, alpha: 1))
        default:
            return (#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        }
    }
    
    var title : String {
        switch type {
        case .bronze:
            return "Bronze"
        case .silver:
            return "Silver"
        case .gold:
            return "Gold"
        default:
            return ""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        Bundle.main.loadNibNamed("BadgeView", owner: self, options: nil)
        addSubview(containerView)
        backgroundColor = UIColor.clear
        containerView.frame = self.bounds
        containerView.autoresizingMask =  [.flexibleWidth, .flexibleHeight]
        containerView.backgroundColor = UIColor.red
        titleLabe.text = "silver"
        badgeCountLabel.text = "2"
    }
    
    public func configureStyle(withType badgeType : Badgetype) {
        type = badgeType
        containerView.backgroundColor = color.backgroundColor
        containerView.layer.borderColor = color.borderColor.cgColor
        titleLabe.text = title
    }
    
    override func draw(_ rect: CGRect) {
        self.containerView.layer.borderWidth = 2.0
        self.containerView.layer.cornerRadius = 8.0
    }
    
    
}
