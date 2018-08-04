//
//  FirstViewController.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/10/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class FeedVC : UIViewController {
    var downloadIsCompleted = false
    var usersEmails : [String] = [String]()
    var usersImages : [UIImage] = [UIImage]()
    var messageArray : [Message] = [Message]()
    let myGroup = DispatchGroup()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            self.fetchAllData()
    }
    
    

}



extension FeedVC : UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else{
            return UITableViewCell()
        }
        cell.configureCell(profileImage: usersImages[indexPath.row],
                           email: usersEmails[indexPath.row],
                           message: messageArray[indexPath.row].content)
        
        return cell
}
    
    
    func fetchAllData(){
        
        DataService.instance.getAllFeedMessages { (returnedMessageArray) in
            self.messageArray = returnedMessageArray.reversed()
            for (index,message) in self.messageArray.enumerated(){
                 self.myGroup.enter()
                DataService.instance.getUsername(forUID: message.SenderId) { (returnedEmail) in
                    print("here is the returned email\(returnedEmail)")
                    self.usersEmails.append(returnedEmail)
                }
                    DataService.instance.getProfileImage(forUID: message.SenderId) { (url, exist) in
                        
                        if exist{
                            do{
                                let data = try Data(contentsOf: url!)
                                let image = UIImage(data: data)
                                self.usersImages.append(image!)
                            }catch{}
                        }else{
                            let image = UIImage(named: "defaultProfileImage")
                            self.usersImages.append(image!)
                            print("no photo on firbase for \(message.SenderId)")
                        }
                        self.myGroup.leave()
                    }
             }
            self.myGroup.notify(queue: .main, execute: {
                self.tableView.reloadData()
            })
          }
       }
    

    }


