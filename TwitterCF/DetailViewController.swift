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
    @IBOutlet weak var imageButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.tweet.isRetweeted {
            
            tweetLabel.text = self.tweet.rqText
            usernameLabel.text = self.tweet.rqUser!.username
            
            
            if let rqUser = self.tweet.rqUser {
                self.navigationItem.title = rqUser.username
            }
            
        } else {
            
            // use normal tweet details
            tweetLabel.text = tweet.text
            usernameLabel.text = tweet?.user?.username
            self.navigationItem.title = tweet.user?.username

            
        }
        
    
        self.downloadRetweetImage()

        
        
    }
    
    
    func downloadRetweetImage() {
        if self.tweet.isRetweeted {
            if let url = NSURL(string: self.tweet.rqUser!.profileImageURL) {
                let downloadQ = dispatch_queue_create("downloadQ", nil)
                dispatch_async(downloadQ, { () -> Void in
                    let imageData = NSData(contentsOfURL: url)!
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let image = UIImage(data: imageData)
                        self.imageButton.setBackgroundImage(image, forState: UIControlState.Normal)
                    })
                    
                })
                
            }
            
        } else {
            if let url = NSURL(string: self.tweet.user!.profileImageURL) {
                let downloadQ = dispatch_queue_create("downloadQ", nil)
                dispatch_async(downloadQ, { () -> Void in
                    let imageData = NSData(contentsOfURL: url)!
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let image = UIImage(data: imageData)
                        self.imageButton.setBackgroundImage(image, forState: UIControlState.Normal)
                    })
                    
                })
                
            }
        }
    }
    
    
    
    
    @IBAction func imagePressed(sender: AnyObject) {
        
        
        self.performSegueWithIdentifier("showUserTweets", sender: nil)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showUserTweets" {
            if self.tweet.isRetweeted {
                
                let segue = segue.destinationViewController as! UserTimelineViewController
                segue.user = self.tweet.rqUser!
                print("retweet user \(segue.user)")
                
            } else {
                
                let segue = segue.destinationViewController as! UserTimelineViewController
                segue.user = self.tweet.user!
                print("original\(segue.user)")
                
            }
        }
        
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
