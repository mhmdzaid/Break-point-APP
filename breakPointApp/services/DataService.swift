//
//  DataService.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/10/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
import Firebase

let D_B = Database.database().reference()
class DataService{
    
    static let instance = DataService()

    private var _REF_BASE = D_B
    private var _REF_USERS  = D_B.child("users")
    private var _REF_FEEDS = D_B.child("feeds")
    private var _REF_GROUPS = D_B.child("groups")

    var REF_BASE:DatabaseReference{
        return _REF_BASE
    }
    
    var REF_USERS:DatabaseReference{
       return _REF_USERS
    }
    
    var REF_FEEDS:DatabaseReference{
        return _REF_FEEDS
    }
    
    var REF_GROUPS:DatabaseReference{
        return _REF_GROUPS
    }

    func creatDBUser(UID : String , UserData : Dictionary<String,Any>) -> Void
    {
        REF_BASE.child(UID).updateChildValues(UserData)
    }
}
