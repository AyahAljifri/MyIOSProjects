//
//  SentMemeCollectionViewController.swift
//  Memo 1.0 Project V2
//
//  Created by apple on 17/04/1440 AH.
//  Copyright © 1440 Student@Udacity. All rights reserved.
//

import Foundation
import UIKit

class SentMemeCollectionViewController: UICollectionViewController {
    
    //  FlowLayout Outlet
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    // ******************************************************* //
    // Meme Array //
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    // ******************************************************* //
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        CollectionView.reloadData()
    //    }
    // ******************************************************* //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    // ******************************************************* //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    // ******************************************************* //
    // Collection View Data Source //
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }
    // ******************************************************* //
    // Collection View Data Source //
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! SentMemeCollectionViewCell
        
        cell.memedImageView.image = memes[indexPath.row].memedImage
        
        return cell
    }
    // ******************************************************* //
    // Collection View Delegate //
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detail = self.storyboard!.instantiateViewController(withIdentifier: "MemeController") as! SentMemeDetailViewController
        
        detail.images = memes[indexPath.row].memedImage
        
        self.navigationController!.pushViewController(detail, animated: true)
    }
    // ******************************************************* //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.bounds.width - 6
        return CGSize(width: availableWidth/2, height: availableWidth/2)
        
    }
    // ******************************************************* //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
    }
    // ******************************************************* //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    // ******************************************************* //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    // ******************************************************* //
    
}
