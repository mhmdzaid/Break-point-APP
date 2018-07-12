//
//  MessageModel.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/12/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation

class Message {
    
    private var _content :String
    private var _SenderId :String
    
    var content :String{
        return _content
    }
    var SenderId:String{
        return _SenderId
    }
    init(content :String , senderId :String) {
        self._content = content
        self._SenderId = senderId
    }
    
    
}
