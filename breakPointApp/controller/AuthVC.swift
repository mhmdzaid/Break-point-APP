//
//  AuthVC.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/10/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import Firebase
class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func facBookSignInBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func googleSignInBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func EmailSignInBtnWasPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
}
