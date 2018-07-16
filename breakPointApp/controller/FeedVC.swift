//
//  FirstViewController.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/10/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class FeedVC : UIViewController {

    var messageArray : [Message] = [Message]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllFeedMessages { (returnedMessageArray) in
            self.messageArray = returnedMessageArray.reversed()
            self.tableView.reloadData()
        }
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
        let message = messageArray[indexPath.row]
        DataService.instance.getProfileImage(forUID: message.SenderId) { (url, exist) in
            if exist{
              do{
                  let data = try Data(contentsOf: url!)
                  let image = UIImage(data: data)
                
                    DataService.instance.getUsername(forUID: message.SenderId) { (returnedEmail) in
                    cell.configureCell(profileImage: image!, email:returnedEmail , message: message.content)
                    }
                }catch{} 
            }else{
            let image = UIImage(named: "defaultProfileImage")
            DataService.instance.getUsername(forUID: message.SenderId) { (returnedEmail) in
                cell.configureCell(profileImage: image!, email:returnedEmail , message: message.content)
            }
            print("no photo on firbase for \(message.SenderId)")
        }
       
    }
        return cell
}

}
