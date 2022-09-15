//
//  Message.swift
//  Peppy
//
//  Created by Admin on 11/08/21.
//

import Foundation
/*
{
    “Chats”: {
        "sender_uuid" : {
            "receiver_uuid" : {
                "msg_uid" : {
                    isseen : Bool
                    msg: String
                    receiver: String
                    sender: String
                    timeStamp: timeStamp
                }
            }
        }
    }
}
*/

class Message {
    public var isseen : Int?
    public var msg : String?
    public var receiver : String?
    public var sender : String?
    public var timeStamp : String?
    
    init(dictionary: [String: Any]) {
        self.isseen = dictionary["isseen"] as? Int
        self.msg = dictionary["msg"] as? String
        self.receiver = dictionary["receiver"] as? String
        self.sender = dictionary["sender"] as? String
        self.timeStamp = dictionary["timeStamp"] as? String
    }
    
}

