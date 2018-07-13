//
//  CreatGroupsVC.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/12/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class CreatGroupsVC: UIViewController {
    var EmailArray : [String] = [String]()
    @IBOutlet weak var titleTextField: insetTextFieldVC!
    @IBOutlet weak var DescribtionTextField: insetTextFieldVC!
    @IBOutlet weak var addedMemberTextField: insetTextFieldVC!
    @IBOutlet weak var addedMembersLabel: UILabel!
    @IBOutlet weak var tableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.delegate = self
        tableVIew.dataSource = self
        addedMemberTextField.delegate = self
        addedMemberTextField.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
    }

    @objc func textfieldDidChange (){
     let query = self.addedMemberTextField.text
        DataService.instance.getEmail(forQuery: query!) { (emails) in
            if self.addedMemberTextField.text == ""{
                self.EmailArray = []
                self.tableVIew.reloadData()
            }else{
                self.EmailArray = emails
                self.tableVIew.reloadData()
            }
        }
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
        return EmailArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableVIew.dequeueReusableCell(withIdentifier: "userCell") as? userCell else{
            return UITableViewCell()
        }
        let image = UIImage(named:"defaultProfileImage")
        cell.configureCell(UsrImage: image! , Email: EmailArray[indexPath.row], isSelected: true)
        return cell
    }
}
extension CreatGroupsVC : UITextFieldDelegate{}
