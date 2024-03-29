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
    let myDispatchGroup = DispatchGroup()
    var messages  = [Message]()
    var profileImages = [UIImage]()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    @IBOutlet weak var groupMembersLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var FeedtableView: UITableView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var messagetextField: insetTextFieldVC!
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismissDetail()
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
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        FeedtableView.dataSource = self
        FeedtableView.delegate = self
        sendButton.bindToKeyBoard()
        messagetextField.bindToKeyBoard()
        self.FeedtableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidekeyBoard)))
        
    }
    
    @objc func hidekeyBoard(){
      self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
                self.fetchAllImagData()
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
        if profileImages.count > 0 {
        DataService.instance.getUsername(forUID: message.SenderId) { (userName) in
            cell.configureCell(message: message.content , email: userName, image: self.profileImages[indexPath.row])
        }
    }
      return cell 
    }
    
    
    
    func fetchAllImagData(){
        
        for message in self.messages{
            myDispatchGroup.enter()
            DataService.instance.getProfileImage(forUID: message.SenderId, completion: { (url, exist) in
                if exist{
                    do{
                        let data = try Data(contentsOf: url!)
                        let image = UIImage(data: data)
                        self.profileImages.append(image!)
                    }catch{}
                }else{
                    let image = UIImage(named: "defaultProfileImage")
                    self.profileImages.append(image!)
                    print("no photo on firbase for \(message.SenderId)")
                }
                self.myDispatchGroup.leave()
            })
        }
        self.myDispatchGroup.notify(queue: .main, execute: {
            print("finished fetching users images \(self.profileImages.count)")
            self.FeedtableView.reloadData()
            self.activityIndicator.stopAnimating()
        })
    }
    
    
}
