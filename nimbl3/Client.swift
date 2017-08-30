//
//  Client.swift
//  nimbl3
//
//  Created by Brandon on 8/21/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import Foundation
import AFNetworking

class Client {
    
    //access token is hard coded. You would want to use User.currentUser.token
    let access_token = "d9584af77d8c0d6622e2b3c554ed520b2ae64ba0721e52daa12d6eaa5e5cdd93"
    
    //as the project grows you would want to put these in a static file of strings
    let baseURL = "https://nimbl3-survey-api.herokuapp.com/"
    let surveyURL = "surveys.json?"
    let tokenURL = "oauth/token?"
    
    static let sharedInstance = Client()
    
    //function for getting either standard 5 surverys or put parameters in for custom output
    func getSurveys(page: Int?, perPage: Int?, completionHandler: @escaping ((_ surveys: [Survey]) -> Void)) {
        
        var parameters: payload = ["access_token": (access_token as Any)]
        
        if let _ = page, let _ = perPage {
            parameters["page"] = page as Any
            parameters["per_page"] = perPage as Any
        }
        
        let manager = AFHTTPSessionManager()
        let urlString = "\(baseURL)\(surveyURL)"
        manager.get(urlString,
                    parameters: parameters,
                    progress: nil,
                    success: { (_, json) -> Void in
                        completionHandler(Survey.surveys(array: json as! [payload]))
        },
                    failure: { (_, error) -> Void in
                        print(error)
        })
    }
    
    //function for getting new token
    func getToken(username: String, password: String, completionHandler: @escaping ((_ token: String) -> Void)) {
        
        let parameters: [String: String] = ["username": "carlos@nimbl3.com",
                                            "password": "antikera",
                                            "grant_type": "password"]
        
        let manager = AFHTTPSessionManager()
        let urlString = "\(baseURL)\(tokenURL)"
        manager.post(urlString,
                    parameters: parameters,
                    progress: nil,
                    success: { (_, json) -> Void in
                        let payload = json as! payload
                        completionHandler(payload["access_token"] as! String)
        },
                    failure: { (_, error) -> Void in
                        print(error)
        })
    }
}
