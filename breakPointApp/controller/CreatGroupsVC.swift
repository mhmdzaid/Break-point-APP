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
    @IBOutlet weak var tableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.delegate = self
        tableVIew.dataSource = self
        
    }

   
    @IBAction func DoneButtonWasPressed(_ sender: Any) {
    }
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CreatGroupsVC : UITableViewDelegate ,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableVIew.dequeueReusableCell(withIdentifier: "userCell") as? userCell else{
            return UITableViewCell()
        }
        let image = UIImage(named:"defaultProfileImage")
        cell.configureCell(UsrImage: image! , Email: "may@yahoo.com", isSelected: true)
        return cell
    }
}
