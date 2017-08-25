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

    let access_token = "d9584af77d8c0d6622e2b3c554ed520b2ae64ba0721e52daa12d6eaa5e5cdd93"
    //"e9d89f267d0bdd7136a96c490cdf4df0976c14626f6660d3470a1cdd66724b6e"

    let baseURL = "https://nimbl3-survey-api.herokuapp.com/"
    let surveyURL = "surveys.json?"
    
    static let sharedInstance = Client()
    
    func getSurveys(completionHandler: @escaping ((_ products: AnyObject) -> Void)) {
        
        let manager = AFHTTPSessionManager()
        let urlString = "\(baseURL)\(surveyURL)"
        manager.get(urlString,
                    parameters: ["access_token": access_token],
                    progress: nil,
                    success: { (_, json) -> Void in
                        completionHandler(Survey.surveys(array: json as! [NSDictionary]) as AnyObject)
            },
                    failure: { (_, error) -> Void in
                        print(error)
            })
    }
    
    func getSurveys(page: Int, perPage: Int, completionHandler: @escaping ((_ products: AnyObject) -> Void)) {
        
        let manager = AFHTTPSessionManager()
        let urlString = "\(baseURL)\(surveyURL)"
        manager.get(urlString,
                    parameters: ["page": 1, "per_page": 10, "access_token": access_token],
                    progress: nil,
                    success: { (_, json) -> Void in
                        completionHandler(Survey.surveys(array: json as! [NSDictionary]) as AnyObject)
        },
                    failure: { (_, error) -> Void in
                        print(error)
        })
    }


    
    /*func getSurveys(page: Int, perPage: Int, completionHandler: @escaping ((_ products: AnyObject) -> Void)) {
        
        var request = URLRequest(url: URL(string: "\(baseURL)\(surveyURL)")!)

        //var request = URLRequest(url: URL(string: "\(baseURL)surveys.json?page=\(page)&per_page=\(perPage)")!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            do {
                let JSON = try JSONSerialization.jsonObject(with: data!, options: []) as! [NSDictionary]
                completionHandler(Survey.surveys(array: JSON) as AnyObject)
            }
            catch {
                print("json error: \(error)")
            }
        }.resume()
    }*/

}
