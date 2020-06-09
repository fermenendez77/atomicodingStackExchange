//
//  UserViewController.swift
//  StackExchange
//
//  Created by Fernando Menendez on 04/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import UIKit
import PureLayout

class UserViewController: UIViewController {
    
    var presenter : UserPresenter?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var badgesStackView: UIStackView!
    @IBOutlet weak var totalBadgesLabel: UILabel!
    
    var bronzeBadgeView : BadgeView?
    var silverBadgeView : BadgeView?
    var goldBadgeView : BadgeView?
    
    init(withPresenter presenter : UserPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBadgesView()
        presenter?.viewDidLoad()
    }
    
    @IBAction func badgesDetailAction(_ sender: Any) {
        presenter?.prepareBadgesView()
    }
    
    func createBadgesView() {
        bronzeBadgeView = BadgeView()
        silverBadgeView = BadgeView()
        goldBadgeView = BadgeView()
        
        badgesStackView.addArrangedSubview(goldBadgeView!)
        badgesStackView.addArrangedSubview(silverBadgeView!)
        badgesStackView.addArrangedSubview(bronzeBadgeView!)
        
        bronzeBadgeView?.configureStyle(withType: .bronze)
        silverBadgeView?.configureStyle(withType: .silver)
        goldBadgeView?.configureStyle(withType: .gold)
    }
}

extension UserViewController : UserView {

    func showAvatar(image: UIImage) {
        avatarImageView.image = image
    }
    
    func show(name: String?) {
        nameLabel.text = name
    }
    
    func show(place : String?) {
        placeLabel.text = place
    }
    
    func show(reputation : String?) {
        reputationLabel.text = reputation
    }
    
    func show(badges : BadgeCounts?) {
        bronzeBadgeView?.numberOfBadges = badges?.bronze ?? 0
        silverBadgeView?.numberOfBadges = badges?.silver ?? 0
        goldBadgeView?.numberOfBadges = badges?.gold ?? 0
        
    }
    
    func show(totalBadges : Int) {
        totalBadgesLabel.text = "🏆 Total badges : \(totalBadges)"
    }
    
    func presentBadgesView(with presenter : BadgesPresenter) {
        let badgesVC = BadgesViewController(withPresenter: presenter)
        navigationController?.pushViewController(badgesVC, animated: true)
    }
}
