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
    
    var lowImage: String?
    var highImage: String?
    
    func loadImage(urlString: String) {
        image = nil
        
        guard urlString != "" else { return }
        
        lowImage = urlString
        highImage = urlString+"l"
        
        let smallImageRequest = URLRequest(url: URL(string: urlString)!)
        let largeImageRequest = URLRequest(url: URL(string: urlString+"l")!)
        
        self.setImageWith(
            smallImageRequest,
            placeholderImage: nil,
            success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                self.image = smallImage
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
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
}

