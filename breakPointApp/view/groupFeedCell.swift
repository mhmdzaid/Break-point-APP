//
//  groupFeedCell.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/14/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class groupFeedCell: UITableViewCell {
 
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    func configureCell(message : String , email:String ,image:UIImage){
        self.messageLabel.text = message
        self.emailLabel.text = email
        self.profileImage.image = image
    }
}
