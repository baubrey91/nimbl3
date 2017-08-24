//
//  SurveyCollectionViewCell.swift
//  nimbl3
//
//  Created by Brandon on 8/21/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class SurveyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundImage: CustomImageView!
    
    //MVVM pattern of setting labels in ViewModel with observer
    var survey: Survey? {
        didSet {
            self.titleLabel.text = survey?.title ?? "error"
            self.descriptionLabel.text = survey?.description ?? "error"
            if let imgURLString = survey?.imageURL {
                backgroundImage.loadImage(urlString: imgURLString)
            }
        }
    }
}
