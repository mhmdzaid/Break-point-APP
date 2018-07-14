//
//  SecondViewController.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/10/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {
    var AllGroups : [Group] = [Group]()
    @IBOutlet weak var groupsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_GROUPS.observe(.value) { (GroupSnapShot) in
            DataService.instance.getAllGroups { (Groups) in
                self.AllGroups = Groups.reversed()
                self.groupsTableView.reloadData()
            }
        }
        
    }

}

extension GroupsVC : UITableViewDelegate ,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupsTableView.dequeueReusableCell(withIdentifier: "GroupCell")as? GroupCell else{
            return UITableViewCell() }
        let title = AllGroups[indexPath.row].title
        let desc = AllGroups[indexPath.row].description
        let count = AllGroups[indexPath.row].memberCount
        cell.configureCell(withTitle:title , andDescription: desc, memberCount: count)
        return cell
    }
}
