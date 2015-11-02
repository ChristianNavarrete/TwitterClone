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
    var userID: Int?
    var profileBackgroundImageURL: String?
    var profileUserImageURL: String?
    var location: String?
    
    init(username: String, profileImageURL:String, userID: Int, profileBGImage: String, location: String) {
        
        self.username = username
        self.profileImageURL = profileImageURL
        self.userID = userID
        self.profileBackgroundImageURL = profileBGImage
        self.location = location
        
    }
    
    
    
    
}