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
        test()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test() {
        var request = URLRequest(url: URL(string: "https://nimbl3-survey-api.herokuapp.com/surveys.json?page=1&per_page=10")!)
        //You can pass any required content types here
        request.httpMethod = "GET"
        // Some bad practice hard coding tokens in the Controller code instead of keychain.
        let access_token = "d9584af77d8c0d6622e2b3c554ed520b2ae64ba0721e52daa12d6eaa5e5cdd93"
        //You endpoint is setup as OAUTH 2.0 and we are sending Bearer token in Authorization header
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, err in
            do {
                let JSON = try JSONSerialization.jsonObject(with: data!, options: []) as! [NSDictionary]
                DispatchQueue.main.async {
                    self.surveys = Survey.surveys(array: JSON)
                    self.collectionView.reloadData()
                }
            }
            catch {
                print("json error: \(error)")
            }
            }.resume()
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

