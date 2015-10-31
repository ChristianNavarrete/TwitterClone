//
//  Tweet.swift
//  TwitterCF
//
//  Created by HoodsDream on 10/26/15.
//  Copyright (c) 2015 HoodsDream. All rights reserved.
//

import Foundation

class Tweet {
    
    
    let text: String
    let id: String?
    var user: User?
    var retweeted: Bool
    
    let rqText:String?
    let rqUser:User?
    let isRetweeted: Bool
    var retweetStatus:Tweet?

    
    init(text: String, rqText: String? = nil, id: String?, user: User? = nil, rqUser: User? = nil, isRetweet:Bool = false) {
        self.text = text
        self.id = id
        self.user = user
        self.retweeted = isRetweet
        self.rqText = rqText
        self.rqUser = rqUser
        self.isRetweeted = isRetweet

    }
    
    
}
