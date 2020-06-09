//
//  OnboardingPresenter.swift
//  StackExchange
//
//  Created by Fernando Menendez on 03/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

protocol OnboardingPresenter {
    
    var dataProvider : ApiDataProvider { get set }
    init(view : OnboardingView, dataProvider: ApiDataProvider)
    func viewDidLoad()
    func findUser(by name : String)
}

class OnboardingPresenterImpl : OnboardingPresenter {
    
    var dataProvider: ApiDataProvider
    private weak var view : OnboardingView?
    
    required init(view: OnboardingView, dataProvider : ApiDataProvider = StackExchangeDataProvider()) {
        self.view = view
        self.dataProvider = dataProvider
    }
    
    func viewDidLoad() {
        
    }
    
    func findUser(by name: String) {
        var queryItems : [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "inname", value: name))
        queryItems.append(URLQueryItem(name: "site", value: "stackoverflow"))
        dataProvider.dataRequest(endpoint: "/users",
                                 queryItems: queryItems,
                                 returnType: APIResponseUsers.self,
                                 completionHandler:  { [weak self] apiReponse in
                                    guard let user = apiReponse.users.first else {
                                        self?.view?.showError()
                                        return
                                    }
                                    self?.view?.showFounded(user: user) },
                                 errorHandler: { [weak self] error in
                                    self?.view?.showError()
                                    
            }
        )
                            
    }
    
    
}
