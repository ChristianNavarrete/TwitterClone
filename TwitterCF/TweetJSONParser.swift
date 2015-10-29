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
                
                print(rootObject)
                
                var tweets = [Tweet]()
                
                // How are the tweetObjects divided inside the JSON, how does it know where to cut off, why doesnt it give the first tweet everytime ? Because we're setting the perameter types as [[String : AnyObject]] in NSJSONSerialization.JSONObjectWithData
                    
                for tweetObject in rootObject {
                    
                    if let text = tweetObject["text"] as? String, id  = tweetObject["id_str"] as? String, user = tweetObject["user"] as? [String:AnyObject]
                        
                        {
                            let tweet = Tweet(text: text, id: id)
                            
                            if let name = user["name"] as? String, profileImageURL = user["profile_image_url"] as? String {
                                tweet.user = User(username: name, profileImageURL: profileImageURL)
                        }
                            
                            tweets.append(tweet)
                            
                        }
                    } 
                
                return tweets
            }
            
        } catch _ {}
        
        return nil
    }
    
    
    class func userFromData(user:[String:AnyObject]) -> User? {
    
        if let name = user["name"] as? String, profileImageURL = user["profile_image_url"] as? String {
            
            return User(username: name, profileImageURL: profileImageURL)
            
        }
        
        return nil
        
    }
    
    
}