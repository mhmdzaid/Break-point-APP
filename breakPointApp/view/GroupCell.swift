//
//  GroupCell.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/13/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var membersLabels: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(withTitle title :String,andDescription description :String,memberCount :Int){
        self.groupTitleLabel.text = title
        self.descriptionLabel.text = description
        self.membersLabels.text = "\(memberCount)_member"
    }

}
