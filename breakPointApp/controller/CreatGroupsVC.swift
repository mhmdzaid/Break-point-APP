//
//  CreatGroupsVC.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/12/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class CreatGroupsVC: UIViewController {

    @IBOutlet weak var titleTextField: insetTextFieldVC!
    @IBOutlet weak var DescribtionTextField: insetTextFieldVC!
    @IBOutlet weak var addedMemberTextField: insetTextFieldVC!
    @IBOutlet weak var addedMembersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

   
    @IBAction func DoneButtonWasPressed(_ sender: Any) {
    }
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
