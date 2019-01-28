//
//  SentMemeTableViewController.swift
//  Memo 2.0 Project 
//
//  Created by apple on 03/04/1440 AH.
//  Copyright © 1440 Student@Udacity. All rights reserved.
//

//////////////////
import UIKit
import Foundation
//////////////////
class SentMemeTableViewController : UIViewController {
   
    // Outlet for the Table View //
    @IBOutlet weak var TableView: UITableView!
    
    // ******************************************************* //
    // Meme Array //
     var memes: [Meme]! {
       let object = UIApplication.shared.delegate
       let appDelegate = object as! AppDelegate
        return appDelegate.memes
}
    // ******************************************************* //
    // To Load the table view content //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TableView.reloadData()
}
    // ******************************************************* //
}
// ************************************************************************************* //
extension SentMemeTableViewController : UITableViewDataSource , UITableViewDelegate {
    // ******************************************************* //
    // Table View Data Source //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memes.count
    }
    // ******************************************************* //
    // Table View Data Source //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell") as! SentMemeTableViewCell
        
        cell.TOP?.text = memes[indexPath.row].topText
        cell.BOTTOM?.text = memes[indexPath.row].bottomText
        cell.memeImageView?.image = memes[indexPath.row].memedImage
        
        return cell
    }
    // ******************************************************* //
    // Table View Delegate //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
       let detail = self.storyboard!.instantiateViewController(withIdentifier: "MemesDetails") as! SentMemeDetailViewController
    
       detail.images = memes[(indexPath as NSIndexPath).row].memedImage
    
       self.navigationController!.pushViewController(detail, animated: true)
}
    // ******************************************************* //
}
