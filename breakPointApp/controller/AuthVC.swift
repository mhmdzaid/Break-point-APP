//
//  AuthVC.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/10/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit

class AuthVC: UIViewController {

  
   
    @IBOutlet weak var faceBookButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        faceBookButton.delegate  = self
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


extension AuthVC : FBSDKLoginButtonDelegate{
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        do{
            try Auth.auth().signOut()
        }catch{}
    }

    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error.localizedDescription)
        }else{
             let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }else{
                    let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC")
                    self.present(tabBar!, animated: true, completion: nil)
                    

                }
            })
        }
    }
}
