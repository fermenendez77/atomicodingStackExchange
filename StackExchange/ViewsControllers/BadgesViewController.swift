//
//  BadgesViewController.swift
//  StackExchange
//
//  Created by Fernando Menendez on 05/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import UIKit

protocol BadgesView : class {
    func loadBadges()
    func showErrorMessage()
}

class BadgesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var colorSortControl: UISegmentedControl!

    var presenter : BadgesPresenter?
    
    init(withPresenter presenter : BadgesPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        self.title = "Badges"
        presenter?.viewDidLoad()
    }
    
    fileprivate func registerCells() {
        tableView.register(UINib(nibName: "BadgesViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    @IBAction func sortColorControlChanged(_ sender: Any) {
        guard let control = sender as? UISegmentedControl else {
            return
        }
        switch control.selectedSegmentIndex {
            case 0:
                presenter?.sortBadgesBy(type: .gold)
            case 1:
                presenter?.sortBadgesBy(type: .silver)
            case 2:
                presenter?.sortBadgesBy(type: .bronze)
            default:
                presenter?.sortBadgesBy(type: .gold)
        }
    }
}

extension BadgesViewController : BadgesView {
    
    func showErrorMessage() {
        let alert = UIAlertController(title: "Error",
                                      message: "An error ocurred trying to get the data",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func loadBadges() {
        self.tableView.reloadData()
    }
}

extension BadgesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.badges.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BadgesViewCell
        presenter?.configure(cell: cell, for: indexPath)
        return cell
    }
    
}

extension BadgesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
