//
//  SentMemeDetailViewController.swift
//  Memo 1.0 Project V2
//
//  Created by apple on 17/04/1440 AH.
//  Copyright © 1440 Student@Udacity. All rights reserved.
//

import Foundation
import UIKit

class SentMemeDetailViewController: UIViewController {
    
    // MARK: Outlet
    @IBOutlet weak var memeImage : UIImageView!
    // MARK: Varible
    var images:  UIImage?
    // *********************************************** //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let images = images {
            memeImage.image = images
        }
        
    }
    // *********************************************** //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    // *********************************************** //
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    // *********************************************** //
}
