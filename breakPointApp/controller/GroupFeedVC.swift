//
//  GroupFeedVC.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/14/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import Firebase
class GroupFeedVC: UIViewController {
    var group :Group?
    var messages  = [Message]()
    @IBOutlet weak var groupMembersLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var FeedtableView: UITableView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var messagetextField: insetTextFieldVC!
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        if messagetextField.text != ""{
            self.sendButton.isEnabled = false
            messagetextField.isEnabled = false
            DataService.instance.UploadPost(withMessage: messagetextField.text!, forUID:(Auth.auth().currentUser?.uid)! , WithGroupKey: (self.group?.key)!, UploadCompleted: { (complete) in
                if complete {
                    self.sendButton.isEnabled = true
                    self.messagetextField.isEnabled = true
                    self.messagetextField.text = ""
                }else{
                    print("there is something wrong")
                }
            })
        }
      
    }
    
    func initGroupData(forGroup group :Group){
     self.group = group
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        FeedtableView.dataSource = self
        FeedtableView.delegate = self
        sendButton.bindToKeyBoard()
        messagetextField.bindToKeyBoard()
        self.FeedtableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidekeyBoard)))
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
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapShot) in
            DataService.instance.getAllMessages(forDesiredGroup: self.group!, handler: { (returnGroupMessages) in
                self.messages = returnGroupMessages.reversed()
                self.FeedtableView.reloadData()
            })
        }
        
    }

}

extension GroupFeedVC : UITableViewDelegate ,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.FeedtableView.dequeueReusableCell(withIdentifier: "groupFeedCell") as? groupFeedCell else{return UITableViewCell()}
        let message = messages[indexPath.row]
        DataService.instance.getUsername(forUID: message.SenderId) { (userName) in
            let image = UIImage(named: "defaultProfileImage")
            cell.configureCell(message: message.content , email: userName, image: image!)
        }
      return cell 
    }
}
