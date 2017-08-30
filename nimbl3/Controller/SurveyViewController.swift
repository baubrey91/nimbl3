//
//  SurveyViewController.swift
//  nimbl3
//
//  Created by Brandon on 8/22/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {

    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // dismiss ViewController
    @IBAction func onCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
