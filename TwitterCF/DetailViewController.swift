//
//  DetailViewController.swift
//  TwitterCF
//
//  Created by HoodsDream on 10/28/15.
//  Copyright © 2015 HoodsDream. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tweet:Tweet!

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.tweet.isRetweeted {
            
            tweetLabel.text = self.tweet.rqText
            usernameLabel.text = self.tweet.rqUser!.username
            
            if let rqUser = self.tweet.rqUser {
                self.navigationItem.title = rqUser.username
                return
            } else {
                self.navigationItem.title = tweet.user?.username
            }
            
        } else {
            // use normal tweet details
            tweetLabel.text = tweet.text
            usernameLabel.text = tweet?.user?.username
        }

        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
