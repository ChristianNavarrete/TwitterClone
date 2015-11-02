//
//  HeaderTableViewCell.swift
//  TwitterCF
//
//  Created by HoodsDream on 11/2/15.
//  Copyright © 2015 HoodsDream. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var bgImage: UIImage?
    var user: User? {
        didSet {
            if let headerUser = user {
                if let backgroundURL = NSURL(string: headerUser.profileBackgroundImageURL!), imageURL = NSURL(string: headerUser.profileImageURL) {
                    let queue = NSOperationQueue()
                    let bgImageData = NSData(contentsOfURL:backgroundURL)
                    let profileImageData = NSData(contentsOfURL: imageURL)
                    queue.addOperationWithBlock({ () -> Void in
                        let bgImage = UIImage(data:bgImageData!)
                        let userImage = UIImage(data:profileImageData!)
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.backgroundImage.image = bgImage
                            self.userImage.image = userImage
                            self.usernameLabel.text = headerUser.username
                            self.locationLabel.text = headerUser.location
                        })
                    })
                }
                
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
