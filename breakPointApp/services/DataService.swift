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
    
    func UploadPost(withMessage message : String,forUID UID :String ,WithGroupKey GroupKey :String?,UploadCompleted completion : @escaping (_ status :Bool)->()){
        
        if GroupKey != nil{
            //send to Group Ref.
        }else{
            REF_FEEDS.childByAutoId().updateChildValues(["content":message,"userID":UID])
            completion(true)
        }
    }
    
    func getAllFeedMessages(handler : @escaping (_ messages : [Message])->()){
        var messageArray : [Message] = [Message]()
        REF_FEEDS.observeSingleEvent(of: .value) { (feedMessageSnapShot) in
            guard let feedMessageSnapShot = feedMessageSnapShot.children.allObjects as? [DataSnapshot] else{
                return
            }
            for message in feedMessageSnapShot{
              let content = message.childSnapshot(forPath: "content").value as! String
              let userID = message.childSnapshot(forPath: "userID").value as! String
              let msg = Message(content: content, senderId: userID)
                messageArray.append(msg)
            }
            handler(messageArray)
        }
    }
    
}
