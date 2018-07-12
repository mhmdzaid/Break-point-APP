//
//  MeVC.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/11/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import Firebase
class MeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var EmailLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.EmailLbl.text  = Auth.auth().currentUser?.email
    }

    @IBAction func SignOutBtnWasPressed(_ sender: Any) {
        let logoutPopUp = UIAlertController(title: "logout?", message: "Are you sure you want to logout !", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "logout?", style: .destructive) { (buttonTapped) in
            do{
              try Auth.auth().signOut()
               let AuthVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC")
               self.present(AuthVC!, animated: true, completion: nil)
            }catch{
                print(error.localizedDescription)
            }
        }
        logoutPopUp.addAction(logoutAction)
        present(logoutPopUp, animated: true, completion: nil)
    }
}
