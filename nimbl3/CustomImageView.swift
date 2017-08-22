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

//Image Cache
let imageCache = NSCache<AnyObject, AnyObject>()

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
        
        //if image is in cache load it otherwise download it
        if let imageFromCache = imageCache.object(forKey: highImage as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        self.setImageWith(
            smallImageRequest,
            placeholderImage: nil,
            success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                if self.lowImage == urlString {
                    self.image = smallImage
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.alpha = 1.0
                    }, completion: { (sucess) -> Void in
                        
                        self.setImageWith(
                            largeImageRequest,
                            placeholderImage: smallImage,
                            success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                //if this is correct image for cell set it otherwise only cache it
                                if self.highImage == urlString+"l" {
                                    self.image = largeImage
                                }
                                imageCache.setObject(largeImage, forKey: urlString+"l" as AnyObject)
                        },
                            failure: { (request, response, error) -> Void in
                        })
                    })
                }
        },
            failure: { (request, response, error) -> Void in
        })
    }
}

