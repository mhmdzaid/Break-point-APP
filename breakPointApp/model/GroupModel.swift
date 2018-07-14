//
//  GroupModel.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/14/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
class Group {
    private var _title :String
    private var _description : String
    private var _key :String
    private var _members : [String]
    private var _memberCount : Int
    
    var title  : String {
        return _title
    }
    var description : String{
        return _description
    }
    var key :String{
        return _key
    }
    var members:[String]{
        return _members
    }
    var memberCount : Int{
        return _memberCount
    }
    
    init(title:String,description:String,key:String,members : [String],memberCount:Int) {
        self._title = title
        self._description = description
        self._key = key
        self._members = members
        self._memberCount = memberCount
    }
}
