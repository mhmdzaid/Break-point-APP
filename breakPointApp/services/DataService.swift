//
//  DataService.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/10/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

let D_B = Database.database().reference()
let storage = Storage.storage().reference()
class DataService{
    
    static let instance = DataService()
    
    private var _REF_IMAGES = storage.child("images")
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
    
    var REF_IMAGES : StorageReference{
        return _REF_IMAGES
    }

    func creatDBUser(UID : String , UserData : Dictionary<String,Any>) -> Void
    {
        REF_USERS.child(UID).updateChildValues(UserData)
    }
    
    func UploadPost(withMessage message : String,forUID UID :String ,WithGroupKey GroupKey :String?,UploadCompleted completion : @escaping (_ status :Bool)->()){
        
        if GroupKey != nil{
            //send to Group Ref.
            REF_GROUPS.child(GroupKey!).child("messages").childByAutoId().updateChildValues(["content":message , "userID":UID])
            completion(true)
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
    
    func getAllMessages(forDesiredGroup group: Group , handler : @escaping (_ groupMessages : [Message])->()){
        var messages : [Message] = [Message]()
        REF_GROUPS.child(group.key).child("messages").observeSingleEvent(of: .value) { (groupMessagesSnapShot) in
            guard let groupMessagesSnapShot = groupMessagesSnapShot.children.allObjects as? [DataSnapshot]else{return}
            for message in groupMessagesSnapShot{
                let content = message.childSnapshot(forPath: "content").value as! String
                let SenderId = message.childSnapshot(forPath: "userID").value as! String
                let msg = Message(content: content, senderId: SenderId)
                messages.append(msg)
            }
            handler(messages)
        }
    }
    
    
    func getUsername(forUID UID :String ,handler : @escaping (_ username:String)->()){
        REF_USERS.observeSingleEvent(of: .value) { (userNameSnapShot) in
            guard let userNameSnapShot = userNameSnapShot.children.allObjects as? [DataSnapshot]else{return}
            for user in userNameSnapShot{
                if UID == user.key {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    
    func getEmail(forQuery query :String , handler : @escaping(_ emailArray:[String])->()){
        var Emails : [String] = [String]()
        REF_USERS.observe(.value) { (UserSnapShot) in
            guard let UserSnapShot = UserSnapShot.children.allObjects as? [DataSnapshot] else{return}
            for user in UserSnapShot{
            let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) && email != Auth.auth().currentUser?.email{
                   Emails.append(email)
                }
            }
            handler(Emails)
        }
    }
    
    
    func getIds(forUsers emails : [String],handler : @escaping (_ idArray:[String])->()){
        var IdArray = [String]()
        REF_USERS.observe(.value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot]else{return}
            for user in userSnapShot{
                let email = user.childSnapshot(forPath: "email").value as! String
                if emails.contains(email){
                    IdArray.append(user.key)
                }
            }
            handler(IdArray)
        }
    }
    
    
    func getEmailsfor(group :Group , handler : @escaping (_ Emails:[String])->()){
        var EmailsToPass = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (UsersSnapShot) in
            guard let UsersSnapShot = UsersSnapShot.children.allObjects as? [DataSnapshot] else{return}
            for user in UsersSnapShot{
                if group.members.contains(user.key){
                   let email =  user.childSnapshot(forPath: "email").value as! String
                    EmailsToPass.append(email)
                }
            }
            handler(EmailsToPass)
        }
    }
    
    func createGroup(withTitle title :String ,andDescription description :String,usersIDs IDS :[String],
                     handler :@escaping (_ groupCreated : Bool)->()){
        REF_GROUPS.childByAutoId().updateChildValues(["title":title,
                                                      "description":description,
                                                      "members":IDS])
        handler(true)
    }
    
    
    func getAllGroups(handler : @escaping (_ groups : [Group])->()){
        var groupArray :[Group] = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapShot) in
            guard let groupSnapShot = groupSnapShot.children.allObjects as? [DataSnapshot]else{return}
            for group in groupSnapShot{
              let members = group.childSnapshot(forPath: "members").value as! [String]
               if members.contains((Auth.auth().currentUser?.uid)!){
                    let groupTitle = group.childSnapshot(forPath: "title").value as! String
                    let desc = group.childSnapshot(forPath:"description").value as! String
                    let GROUP = Group(title: groupTitle, description: desc, key: group.key, members: members, memberCount: members.count)
                groupArray.append(GROUP)
                }
            }
            handler(groupArray)
         }
        }
    
    
    
    func uploadImage(forUID UID :String,imageURL :URL,completion : @escaping(_ status : Bool)->()){
        
        REF_IMAGES.child(UID).putFile(from: imageURL, metadata: nil) { (_, error) in
            if error != nil{
                print(error!.localizedDescription)
                completion(false)
            }else{
                print("successfully uploaded")
                completion(true)
            }
            
        }
    }
    
    func getProfileImage(forUID UID :String , completion : @escaping(_ url : URL?,_ exists :Bool)->()){
        
        REF_IMAGES.child(UID).downloadURL { (returnedURL, error) in
            if error == nil{
                completion(returnedURL!,true)
                
            }else{
                print(error!.localizedDescription)
                completion(nil,false)
            }
        }
        
    }
        
    }
    

