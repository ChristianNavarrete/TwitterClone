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
    let id: String
    var user: User?

    
    init(text:String, id:String, user: User? = nil) {
        self.text = text
        self.id = id
        self.user = user

    }
    
    
}
