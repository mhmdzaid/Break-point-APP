//
//  AuthService.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/11/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
import Firebase

class AuthService{
    
    static let instance = AuthService()
    
    func createUser(withEmail Email : String ,andPassword password : String,userCreationComplete : @escaping (_ status : Bool ,_ error : Error?)->()){
     
        Auth.auth().createUser(withEmail: Email, password: password) { (user, error) in
            guard let user = user else{
                userCreationComplete(false, error)
                return
            }
            let userData = ["provider": user.providerID , "email":user.email]
            DataService.instance.creatDBUser(UID: user.uid, UserData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    
    func loginUser(withEmail Email : String ,andPassword password : String,userLoginCompletion :@escaping (_ status : Bool ,_ error : Error?)->()){
        Auth.auth().signIn(withEmail: Email, password: password) { (user, error) in
            guard let _ = user else{
                userLoginCompletion(false, error)
                return
            }
            userLoginCompletion(true, nil)
        }
    }
  
}
