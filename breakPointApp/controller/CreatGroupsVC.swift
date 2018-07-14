//
//  CreatGroupsVC.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/12/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import Firebase
class CreatGroupsVC: UIViewController {
    var EmailArray : [String] = [String]()
    var chosenEmailArray : [String ] = [String]()
    @IBOutlet weak var titleTextField: insetTextFieldVC!
    @IBOutlet weak var DescribtionTextField: insetTextFieldVC!
    @IBOutlet weak var addedMemberTextField: insetTextFieldVC!
    @IBOutlet weak var addedMembersLabel: UILabel!
    @IBOutlet weak var tableVIew: UITableView!
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.delegate = self
        tableVIew.dataSource = self
        addedMemberTextField.delegate = self
        addedMemberTextField.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doneButton.isHidden = true
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
        if titleTextField.text != "" && DescribtionTextField.text != ""{
          
            DataService.instance.getIds(forUsers: chosenEmailArray) { (userIDs) in
            var IDs = userIDs
            IDs.append((Auth.auth().currentUser?.uid)!)
                DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDescription: self.DescribtionTextField.text!, usersIDs:IDs , handler: { (groupCreated) in
                    if groupCreated{
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        print("there was an error creating the group")
                    }
                })
            }
       
        }
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
        if chosenEmailArray.contains(EmailArray[indexPath.row]){
        cell.configureCell(UsrImage: image! , Email: EmailArray[indexPath.row], isSelected: true)
        }else{
        cell.configureCell(UsrImage: image! , Email: EmailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableVIew.cellForRow(at: indexPath)as? userCell else{return}
        if !chosenEmailArray.contains(cell.EmailLabel.text!){
            chosenEmailArray.append(cell.EmailLabel.text!)
            addedMembersLabel.text = chosenEmailArray.joined(separator: ", ")
            doneButton.isHidden = false
        }else{
            chosenEmailArray = chosenEmailArray.filter({ $0 != cell.EmailLabel.text! })
            if chosenEmailArray.count >= 1 {
                addedMembersLabel.text = chosenEmailArray.joined(separator: ", ")
            }else{
                addedMembersLabel.text = "add people to your group"
                doneButton.isHidden = true
            }
        }
    }
}
extension CreatGroupsVC : UITextFieldDelegate{}
