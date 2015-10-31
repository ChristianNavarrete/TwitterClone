//
//  TweetJSONParser.swift
//  TwitterCF
//
//  Created by HoodsDream on 10/26/15.
//  Copyright (c) 2015 HoodsDream. All rights reserved.
//

import Foundation


class TweetJSONParser {
    
    
    class func tweetFromJSONData(json: NSData) -> [Tweet]? {
        
        do {
            
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(json, options:
                NSJSONReadingOptions.MutableContainers) as? [[String : AnyObject]]  {
                                        
                    var tweets = [Tweet]()
                    
                    for tweetObject in rootObject {
                        
                        if let text = tweetObject["text"] as? String,  id = tweetObject["id_str"] as? String, user = tweetObject["user"] as? [String: AnyObject] {
                            
                            let isRetweet = self.isRetweeted(tweetObject)
                            
                            if isRetweet.0 == true {
                                if let retweetObject = isRetweet.1 {
                                    if let retweetText = retweetObject["text"] as? String, retweetUser = retweetObject["user"] as? [String: AnyObject] {
                                        
                                        if let retweetUser = self.userFromData(retweetUser), user = userFromData(user) {
                                            
                                            let tweet = Tweet(text: text, rqText: retweetText, id: id, user: user, rqUser: retweetUser, isRetweet: true)
                                            tweets.append(tweet)
                                            
                                        }
                                    }
                                    
                                }
                            } else {
                                
                                let tweet = Tweet(text: text, id: id)
                                
                                
                                if let user = self.userFromData(user) {
                                    tweet.user = user
                                    tweets.append(tweet)
                                }
                                
                            }
                            
                            
                            
                        }
                        
                    }
                    
                    return tweets
            }
            
        } catch _ {
            
            return nil
            
        }
        
        return nil
    }
    
    
    
    class func isRetweeted(tweetObject: [ String: AnyObject]) -> (Bool, [String:AnyObject]?) {
        
        if let retweetObject = tweetObject["retweeted_status"] as? [String : AnyObject] {
            if let _ = retweetObject["text"] as? String, _ = retweetObject["name"] as? [String: AnyObject] {
                return (true,retweetObject)
            }
        }
        
        return (false, nil)
    }
    
    
    
    class func userFromData(user:[String:AnyObject]) -> User? {
        
        if let name = user["name"] as? String, profileImageURL = user["profile_image_url"] as? String {
            
            return User(username: name, profileImageURL: profileImageURL)
            
        }
        
        return nil
        
    }
    
    
}



                                        