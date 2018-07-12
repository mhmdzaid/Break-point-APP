//
//  FeedCell.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/12/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var EmailLabel: UILabel!
    
    @IBOutlet weak var messageContent: UILabel!
    
    
    func configureCell(profileImage : UIImage , email : String , message : String){
        self.EmailLabel.text = email
        self.profileImage.image = profileImage
        self.messageContent.text = message
    }
    
}
