//
//  User.swift
//  TwitterCF
//
//  Created by HoodsDream on 10/27/15.
//  Copyright © 2015 HoodsDream. All rights reserved.
//

import Foundation
import UIKit



class User {
    
    let username: String
    let profileImageURL: String
    var image : UIImage?
    
    init(username: String, profileImageURL:String) {
        
        self.username = username
        self.profileImageURL = profileImageURL
        
    }
    
    
    
    
}