//
//  userCell.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/12/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class userCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    func configureCell(UsrImage :UIImage,Email :String,isSelected:Bool){
        self.userImage.image = UsrImage
        self.EmailLabel.text = Email
        if isSelected{
            self.checkImage.isHidden = false
        }else{
            self.checkImage.isHidden = true
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
