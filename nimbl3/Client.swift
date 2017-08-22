//
//  Client.swift
//  nimbl3
//
//  Created by Brandon on 8/21/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import Foundation

class Client {
    
    let access_token = "d9584af77d8c0d6622e2b3c554ed520b2ae64ba0721e52daa12d6eaa5e5cdd93"
    let baseURL = "https://nimbl3-survey-api.herokuapp.com/"
    
    static let sharedInstance = Client()
    
    func getSurveys(completionHandler: @escaping ((_ products: AnyObject) -> Void)) {
        
        var request = URLRequest(url: URL(string: "\(baseURL)surveys.json?page=1&per_page=10")!)
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
    }
}
