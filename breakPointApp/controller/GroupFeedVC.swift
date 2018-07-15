//
//  GroupFeedVC.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/14/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {
    var group :Group?
    @IBOutlet weak var groupMembersLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var FeedtableView: UITableView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var messagetextField: insetTextFieldVC!
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendButtonPressed(_ sender: Any) {
        
    }
    
    func initGroupData(forGroup group :Group){
     self.group = group
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.bindToKeyBoard()
        messagetextField.bindToKeyBoard()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidekeyBoard)))
    }
    
    @objc func hidekeyBoard(){
      self.view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.groupNameLabel.text = group!.title
        DataService.instance.getEmailsfor(group: self.group!) { (returnedEmails) in
            self.groupMembersLabel.text = returnedEmails.joined(separator: ", ")
        }
        
    }

}
