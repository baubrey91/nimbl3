//
//  CustomImageView.swift
//  nimbl3
//
//  Created by Brandon on 8/21/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking

class CustomImageView: UIImageView {
    
    //AFNetowrking passes in an image string. Asychronosly loads image and cahces it.
    //Once the low quality image is set then the completion handler downloads and sets the high quality image.
    
    func loadImage(urlString: String) {
        image = nil
        
        guard canOpenURL(string: urlString) else { return }
        
        let smallImageRequest = URLRequest(url: URL(string: urlString)!)
        let largeImageRequest = URLRequest(url: URL(string: urlString+"l")!)
        
        self.setImageWith(
            smallImageRequest,
            placeholderImage: nil,
            success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                self.alpha = 0.0
                self.image = smallImage
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    self.alpha = 1.0
                }, completion: { (sucess) -> Void in
                
                    self.setImageWith(
                        largeImageRequest,
                        placeholderImage: smallImage,
                        success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                            self.image = largeImage
                            
                    },
                        failure: { (request, response, error) -> Void in
                    })
                })
        },
            failure: { (request, response, error) -> Void in
        })
    }
    
    //Helper function to make sure the url is valid
    fileprivate func canOpenURL(string: String?) -> Bool {
        guard let urlString = string else {return false}
        guard let url = NSURL(string: urlString) else {return false}
        if !UIApplication.shared.canOpenURL(url as URL) {return false}
        
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
}

