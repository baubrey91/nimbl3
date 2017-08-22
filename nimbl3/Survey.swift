//
//  Survey.swift
//  nimbl3
//
//  Created by Brandon on 8/21/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import Foundation

class Survey {
    
    var title: String?
    var description: String?
    var imageURL: String?
    
    init(dictionary: NSDictionary) {
        title = dictionary["title"] as? String
        description = dictionary["description"] as? String
        imageURL = dictionary["cover_image_url"] as? String
    }
    
    //create array of products by passing in json array
    class func surveys(array: [NSDictionary]) -> [Survey] {
        var surveys = [Survey]()
        for dictionary in array {
            let survey = Survey(dictionary: dictionary)
            surveys.append(survey)
        }
        return surveys
    }
}
