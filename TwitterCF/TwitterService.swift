//
//  TwitterService.swift
//  TwitterCF
//
//  Created by HoodsDream on 10/27/15.
//  Copyright © 2015 HoodsDream. All rights reserved.
//

import Foundation
import Accounts
import Social

//typealias when we want to define a convinient completion handler
typealias TwitterServiceCompletion = (String?, User?) -> ()


class TwitterService {
    
    //static so that we only use one instance of TwitterService class
    static let sharedService = TwitterService()
    
    var account:ACAccount?
    var user: User?
    
    
    
    
    class func getAuthUser(completion: TwitterServiceCompletion) {
        
        //in this request we're going to verify user credentials we got from out user object in LoginService.loginTwitter() in HomeViewController
        let url = NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")!
        
        // initializes a new request object
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: url, parameters: nil)
        
        // we make sure that we have set an account in getAccount() using LoginService.loginTwitter() in HomeViewController
        // in other words if we have the account what are we going to do with it
        if let account = self.sharedService.account {
            
            //by setting the account to the request the necessary tokens are added automatically
            request.account = account
            
            //performs an asynchronous request and calls specified handler when done
            //Why are we not using THROWS is it because the do-try-catch has a default ????????
            request.performRequestWithHandler { (data, response, error) -> Void in
                
                
                //create a switch statement to handle the error messages depending on HTTP Status Codes
                switch response.statusCode {
                    
                case 200...299:
                    //creating a do-try-catch to handle a positive HTTP Status Code
                    do {
                        if let userData = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String : AnyObject] {
                            if let user = TweetJSONParser.userFromData(userData){
                                
                                completion(nil, user); return
                                
                            }
                            
                            completion("ERROR: unable create user object from de-serialized JSON object", nil)
                        }
                    } catch {
                        completion("ERROR: NSJSONSerialization.JSONObjectWithData was unable to de-serialize JSON object.", nil)
                    }
                    
                case 400...499:
                    
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(response.statusCode) [user input error].", nil) //why do we not add ; return ?
                    
                case 500...599:
                    
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(response.statusCode) [server side error].", nil) //why do we not add ; return ?
                    
                default:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(response.statusCode) [unknown error].", nil) //why do we not add ; return ?
                }
                
                
            }
            
        }
        
    }
    
    
    
    
    
    typealias TweetsCompletion = (String?, [Tweet]?) -> ()
    
    
    class func tweetsFromHomeTimeline(completion: TweetsCompletion) {
        
        var param = [String:AnyObject]()
        param["count"] = 4
        
        //in this request we're going to grab the users home timeline
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL:NSURL(string:"https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: param)
        
        if let account = self.sharedService.account {
            
            //set the account on request so to load up all the credentials
            request.account = account
            
            
            request.performRequestWithHandler { (data, response, error) -> Void in
                
                if let error = error {
                    print(error.description)
                    completion("SLRequest Error type .GET for .json timeline, could not retrieve", nil); return
                    
                }
                
                
                
                switch response.statusCode {
                case 200...299:
                    
                    let tweets = TweetJSONParser.tweetFromJSONData(data)
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        completion(nil, tweets)
                    })
                    
                case 400...499:
                completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [user input error].", nil)
                case 500...599:
                completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [server side error].", nil)
                default:
                completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [unknown error].", nil)
                
                }
            
            }

        }
        
    }
    
}
