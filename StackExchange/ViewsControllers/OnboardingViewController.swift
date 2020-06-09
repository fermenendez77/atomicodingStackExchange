//
//  ViewController.swift
//  StackExchange
//
//  Created by Fernando Menendez on 01/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import UIKit
import OAuthSwift

protocol OnboardingView : class {
    
    func showFounded(user : User)
    func showError()
}

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var presenter : OnboardingPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = OnboardingPresenterImpl(view: self)
        usernameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                    for: .editingChanged)
        configureIntialState()
    }
    
    func configureIntialState() {
        loginButton.isEnabled = false
        indicatorView.isHidden = true
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        login()
    }
    
    
    func login() {
        guard let username = usernameTextField.text else {
            return
        }
        presenter?.findUser(by: username)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = usernameTextField.text  {
            loginButton.isEnabled = text.count > 0
        }
    }
    
    /*
    func login() {
      
        let oauthswift = OAuth2Swift(
            consumerKey:    "18021",
            consumerSecret: "1C7zDNYkrIQ1d894eYCjUQ((",
            authorizeUrl:   "https://stackoverflow.com/oauth",
            responseType:   "code"
        )
        
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
        oauthswift.allowMissingStateCheck = true

        guard let callbackURL = URL(string: "com.fermenendez.atomicoding:/oauth2Callback") else { return }

        oauthswift.authorize(withCallbackURL: callbackURL, scope: "", state:"") { result in
            switch result {
            case .success(let credential, let response,  let parameters):
                print(credential.oauthToken)
                print(response)
                print(parameters)
            case .failure(let error):
                print(error)
            }
        }
    }*/
}

extension OnboardingViewController : OnboardingView {
    
    func showFounded(user: User) {
        indicatorView.isHidden = true
        indicatorView.stopAnimating()
        let presenter = UserPresenterImp(user: user)
        let userVC = UserViewController(withPresenter: presenter)
        navigationController?.pushViewController(userVC, animated: true)
    }
    
    func showError() {
        indicatorView.isHidden = true
        indicatorView.stopAnimating()
        let alert = UIAlertController(title: "Error",
                                      message: "An error ocurred trying to get the data",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

