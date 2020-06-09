//
//  BadgesPresenter.swift
//  StackExchange
//
//  Created by Fernando Menendez on 05/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation



protocol BadgesPresenter {
    
    var user : User { get set }
    var badges : [Badge] { get }
    var view : BadgesView? { get set }
    
    init(withUser user : User, dataProvider : ApiDataProvider)
    
    func viewDidLoad()
    func configure(cell: BadgesViewCell, for indexPath: IndexPath)
    func sortBadgesBy(type : Badgetype)
}

class BadgesPresenterImpl : BadgesPresenter {
    
    var user : User
    var badges : [Badge] = []
    lazy var badgesWeight : [Badgetype : BadgeWeight] = {
        var weights : [Badgetype : BadgeWeight] = [:]
        let gold = BadgeWeight(goldWeight: 3, silverWeight: 2, bronzeWeight: 1)
        let silver = BadgeWeight(goldWeight: 2, silverWeight: 3, bronzeWeight: 1)
        let bronze = BadgeWeight(goldWeight: 1, silverWeight: 2, bronzeWeight: 3)
        weights[.gold] = gold
        weights[.silver] = silver
        weights[.bronze] = bronze
        return weights
    }()
    
    public weak var view : BadgesView?
    
    private var dataProvider : ApiDataProvider
    
    required init(withUser user : User, dataProvider : ApiDataProvider = StackExchangeDataProvider() ) {
        self.user = user
        self.dataProvider = dataProvider
    }
    
    func viewDidLoad() {
        requestBadges()
    }
    
    func sortBadgesBy(type : Badgetype) {
        
        badges.sort(by: { leftBadge, rightBadge in
            let weights = badgesWeight[type]
            guard let leftWeight = weights?.weightBy(type: leftBadge.rank),
                let rightWeight = weights?.weightBy(type: rightBadge.rank) else {
                    return false
            }
            return leftWeight > rightWeight
        })
        view?.loadBadges()
    }
    
    private func requestBadges() {
        guard let userId = user.userID else {
            view?.showErrorMessage()
            return
        }
        var queryItems : [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "site", value: "stackoverflow"))
        queryItems.append(URLQueryItem(name: "sort", value: "rank"))
        queryItems.append(URLQueryItem(name: "pagesize", value: "100"))
        queryItems.append(URLQueryItem(name: "order", value: "asc"))
        dataProvider.dataRequest(endpoint: "/users/\(userId)/badges",
                                 queryItems: queryItems,
                                 returnType: APIResponseBadges.self,
                                 completionHandler: { [weak self] apiReponse in
                                    self?.badges = apiReponse.items
                                    self?.view?.loadBadges() },
                                 errorHandler: { [weak self] error in
                                    self?.view?.showErrorMessage()
        })
    }
    
    func configure(cell: BadgesViewCell, for indexPath: IndexPath) {
        let badge = badges[indexPath.row]
        cell.nameLabel.text = badge.name
        cell.amountLabel.text = "x\(badge.awardCount)"
        cell.setBadge(type: badge.rank)
        
    }
    
}

struct BadgeWeight {
    let goldWeight : Int
    let silverWeight : Int
    let bronzeWeight : Int
    
    func weightBy(type : Badgetype) -> Int {
        switch type {
        case .gold:
            return goldWeight
        case .silver:
            return silverWeight
        case .bronze:
            return bronzeWeight
        }
    }
}
