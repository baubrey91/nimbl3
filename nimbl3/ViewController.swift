//
//  ViewController.swift
//  nimbl3
//
//  Created by Brandon on 8/21/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var surveys = [Survey]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Client.sharedInstance.getSurveys(completionHandler: {
            surveys in DispatchQueue.main.async {
                self.surveys = surveys as! [Survey]
                self.collectionView.reloadData()
            }
        })
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return surveys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "SurveyCollectionViewCell", for: indexPath) as! SurveyCollectionViewCell
        cell.survey = surveys[indexPath.row]
        return cell
    }
}

