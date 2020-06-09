//
//  StackExchangeDataProvider.swift
//  StackExchange
//
//  Created by Fernando Menendez on 03/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

protocol ApiDataProvider : class{
    var urlBase : String { get set }
    var urlSession : URLSession { get set }
    func dataRequest<T : Decodable>(endpoint : String,
                                    queryItems : [URLQueryItem],
                                    returnType : T.Type,
                                    completionHandler: @escaping (T) -> Void,
                                    errorHandler : @escaping (DataRequestError) -> Void)
}

class StackExchangeDataProvider : ApiDataProvider {
   
    var urlBase: String = "api.stackexchange.com"
    var urlSession: URLSession = URLSession(configuration: .default)
    
    func dataRequest<T>(endpoint: String,
                        queryItems: [URLQueryItem],
                        returnType: T.Type,
                        completionHandler: @escaping (T) -> Void,
                        errorHandler: @escaping (DataRequestError) -> Void) where T : Decodable {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = urlBase
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data else {
                    errorHandler(.notFoundError)
                    return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
                
            } catch {
                errorHandler(.parseError)
            }
            
        }
        dataTask.resume()
    }
    
}

enum DataRequestError : Error {
    case parseError
    case connectionError
    case notFoundError
}
