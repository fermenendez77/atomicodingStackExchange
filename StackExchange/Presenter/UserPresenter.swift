//
//  UserPresenter.swift
//  StackExchange
//
//  Created by Fernando Menendez on 04/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol UserPresenter : class {
    var user : User { get set }
    var view : UserView? { get set }
    init(user : User)
    
    func viewDidLoad()
    func prepareBadgesView()
}

protocol UserView : class {
    
    func showAvatar(image : UIImage)
    func show(name : String?)
    func show(place : String?)
    func show(reputation : String?)
    func show(badges : BadgeCounts?)
    func show(totalBadges : Int)
    func presentBadgesView(with presenter : BadgesPresenter)
}

class UserPresenterImp : UserPresenter {
   
    var user : User
    internal weak var view : UserView?
    
    required init(user : User) {
        self.user = user
    }
    
    func viewDidLoad() {
        view?.show(name: user.displayName)
        view?.show(place: user.location)
        view?.show(reputation : String(user.reputation ?? 0))
        view?.show(badges: user.badgeCounts)
        view?.show(totalBadges : sumBadges(badgeCounts: user.badgeCounts))
        loadImageAvatar()
    }
    
    func prepareBadgesView() {
        let presenter = BadgesPresenterImpl(withUser: user)
        view?.presentBadgesView(with: presenter)
    }
       
    
    func loadImageAvatar() {
        DispatchQueue.global().async { [weak self] in
            guard let profileImage = self?.user.profileImage,
                let url = URL(string : profileImage),
                let data = try? Data(contentsOf: url) else {
                    return
            }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.view?.showAvatar(image: image)
                }
            }
        }
    }
    
    func sumBadges(badgeCounts : BadgeCounts? ) -> Int {
        guard let badgeCounts = badgeCounts else {
            return 0
        }
        return badgeCounts.bronze + badgeCounts.silver + badgeCounts.gold
    }
}
