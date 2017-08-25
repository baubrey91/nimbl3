//
//  ViewController.swift
//  nimbl3
//
//  Created by Brandon on 8/21/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit
import SVProgressHUD
import ReachabilitySwift

class SurveysViewController: UIViewController {
    
    //MARK:- Variables
    let reachability = Reachability()!
    var page = 1
    var perPage = 10
    
    var surveys = [Survey]() {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = surveys.count
        }
    }
    
    //IBoutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getSurveys),
                                               name: NSNotification.Name.UIApplicationDidBecomeActive,
                                               object: nil)
        pageControl.transform = pageControl.transform.rotated(by: .pi/2)
        getSurveys()
    }
    
    //MARK:- Functions
    //Check if network it reachable before trying to call service
    func getSurveys() {
        if reachability.isReachable {
            SVProgressHUD.show()
            Client.sharedInstance.getSurveys(page: nil,
                                             perPage: nil,
                                             completionHandler: {
                surveys in DispatchQueue.main.async {
                    self.surveys = surveys as! [Survey]
                    SVProgressHUD.dismiss()
                }
            })
        } else {
            let alert = UIAlertController(title: "Uh Oh",
                                          message: "You are not connected to the internet",
                                          preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: { (alert) in
                
            })
            alert.addAction(action)
            self.present(alert,
                         animated: true,
                         completion: nil)
        }
    }
    
    @IBAction func onRefreshButton(_ sender: Any) {
        getSurveys()
    }
}

//MARK:- Collection View
extension SurveysViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        let height = self.view.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return surveys.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "SurveyCollectionViewCell",
                                                           for: indexPath) as! SurveyCollectionViewCell
        cell.survey = surveys[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
        updatePageControl()
    }
    
    //helper function to give custom look to page indicator
    private func updatePageControl() {
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

