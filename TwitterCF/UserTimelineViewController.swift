//
//  UserTimelineViewController.swift
//  TwitterCF
//
//  Created by HoodsDream on 10/31/15.
//  Copyright © 2015 HoodsDream. All rights reserved.
//

import UIKit
import Social

class UserTimelineViewController: UITableViewController {
    
    var maxID:Int? = nil
    
    var tweets = [Tweet]()
    
    var user : User?
    var allTweetIds = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let customTweetCell = UINib(nibName:"CustomTweetCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(customTweetCell, forCellReuseIdentifier: "CustomTweetCell")
        
        let customHeader = UINib(nibName: "CustomViewHeader", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(customHeader, forCellReuseIdentifier: "CustomViewHeader")
        
        self.getTweets()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationItem.title = "Tweets"
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        
        self.tableView.estimatedSectionHeaderHeight = 144.0
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("CustomViewHeader") as! HeaderTableViewCell
        
        headerCell.user = self.user!
        
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }
    
    // mark : array extension
    
    
    
    

    
    func getTweets() {
        
        let userID = self.user!.userID!
        
        TwitterService.grabFollowerTweets (userID) { ( error, tweets) -> () in
            if let tweets = tweets {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tweets = tweets
                    self.tableView.reloadData()
                    print(tweets)
                    
                })
                
            }
            
        }        
    }
    
    func getMoreTweets() {
        
        let userID = self.user!.userID!
        
        TwitterService.grabFollowerTweets (userID, maxID: maxID) { ( error, tweets) -> () in
            if let tweets = tweets {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tweets = self.tweets + tweets
                    self.tableView.reloadData()
                    print(tweets)
                    
                })
                
                

                
            }
            
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tweets.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomTweetCell", forIndexPath: indexPath) as! CustomTweetCell
        
        cell.tweet = self.tweets[indexPath.row]

        return cell
    }
    

 
}
