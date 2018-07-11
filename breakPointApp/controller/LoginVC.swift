//
//  LoginVC.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/10/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var EmailField: insetTextFieldVC!
    @IBOutlet weak var PasswordField: insetTextFieldVC!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func SignInBtnWasPressed(_ sender: Any) {
        if EmailField.text != nil && PasswordField.text != nil {
            AuthService.instance.loginUser(withEmail: EmailField.text!, andPassword: PasswordField.text!, userLoginCompletion: { (success, loginError) in
                if success{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print(String(describing:loginError?.localizedDescription))
                }
                
                
                AuthService.instance.createUser(withEmail: self.EmailField.text!, andPassword: self.PasswordField.text!, userCreationComplete: { (success, RegisterationError) in
                    if success{
                        AuthService.instance.loginUser(withEmail: self.EmailField.text!, andPassword: self.PasswordField.text!, userLoginCompletion: { (success, LoginError) in
                           self.dismiss(animated: true, completion: nil)
                           print("successfully registeredd")
                        })
                    }else{
                        print(String(describing:RegisterationError?.localizedDescription))
                    }
                })
            })
        }
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
extension LoginVC : UITextFieldDelegate{}
