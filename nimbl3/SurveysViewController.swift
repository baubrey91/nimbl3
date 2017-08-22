//
//  ViewController.swift
//  nimbl3
//
//  Created by Brandon on 8/21/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class SurveysViewController: UIViewController {
    
    var surveys = [Survey]() {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = surveys.count
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.transform = pageControl.transform.rotated(by: .pi/2)
        
        Client.sharedInstance.getSurveys(completionHandler: {
            surveys in DispatchQueue.main.async {
                self.surveys = surveys as! [Survey]
                //self.collectionView.reloadData()
            }
        })
    }
    
    func updatePageControl() {
        for (index, dot) in pageControl.subviews.enumerated() {
            if index == pageControl.currentPage {
                dot.backgroundColor = .white
                dot.layer.cornerRadius = dot.frame.size.height / 2;
            } else {
                dot.backgroundColor = UIColor.clear
                dot.layer.cornerRadius = dot.frame.size.height / 2
                dot.layer.borderColor = UIColor.white.cgColor
                dot.layer.borderWidth = 1.0
            }
        }
    }
}

//MARK:- collection view

extension SurveysViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        let height = self.view.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return surveys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "SurveyCollectionViewCell", for: indexPath) as! SurveyCollectionViewCell
        cell.survey = surveys[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
        updatePageControl()
    }
}

