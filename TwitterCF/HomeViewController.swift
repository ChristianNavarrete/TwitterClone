//
//  ViewController.swift
//  TwitterCF
//
//  Created by HoodsDream on 10/26/15.
//  Copyright (c) 2015 HoodsDream. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    var detailTweet = Tweet?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let customTweetCell = UINib(nibName: "CustomTweetCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(customTweetCell, forCellReuseIdentifier: "CustomTweetCell")
        
        
        self.getAccount()
    }

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func getAccount() {
        LoginService.loginTwitter({ (error, account) -> () in
            
            //incase get an error back
            if let error = error {
                print(error)
                return
            }
            
            //if LoginService.loginTwitter successfully gets an account, run what's inside the closure
            if let account = account {
                
                //set account property inside (static let sharedService:TwitterService()) to = account
                TwitterService.sharedService.account = account
                
                //execute self.autheticateUser() method
                self.authenticateUser()
                
            }
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.detailTweet = tweets[indexPath.row]
        
        self.performSegueWithIdentifier("showTweet", sender: self)
        
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTweet"
        {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let tweet = self.tweets[indexPath.row]
                let tweetsDetailViewController = segue.destinationViewController as! DetailViewController
                tweetsDetailViewController.tweet = tweet
            }
        }
    }
    
    
    
    
    func authenticateUser(){
        TwitterService.getAuthUser { (error, user) -> () in
            if let error = error {
                print(error)
                return
            }
            
            if let user = user {
                TwitterService.sharedService.user = user
                self.getTweets()
            }
        }
    }
    
    
    
    
    func getTweets() {
        TwitterService.tweetsFromHomeTimeline { (error, tweets) -> () in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            }
        
        }
    }
    
    
    // MARK: UITableView
    
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomTweetCell", forIndexPath: indexPath) as! CustomTweetCell
        
        cell.tweet = self.tweets[indexPath.row]
        
        return cell
    }
        
}



