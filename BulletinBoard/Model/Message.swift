//
//  Message.swift
//  BulletinBoard
//
//  Created by Jason Mandozzi on 7/8/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation
import CloudKit

class Message {
    
    //class properties
    let text: String
    let timestamp: Date
    
    
    //creating an instance of CKRecord
    var cloudKitRecord: CKRecord {
        //Define the record type
        let record = CKRecord(recordType: MessageConstants.typeKey)
        //set your key value pairs
        record.setValue(text, forKey: MessageConstants.textKey)
        record.setValue(timestamp, forKey: MessageConstants.timestampKey)
        //return the record
        return record
        
    }
    //Class initializer
    init(text: String, timestamp: Date = Date()) {
        self.text = text
        self.timestamp = timestamp
    }
    
    //checking to make sure that values we are getting back match up using a failable initializer
    init?(record: CKRecord) {
        //Guard against key/value pair, type cast to ensure that what we are getting back matches up with the types that we want
        guard let text = record[MessageConstants.textKey] as? String,
        let timestamp = record[MessageConstants.timestampKey] as? Date
            else {return nil}
        //initalize the class
        self.text = text
        self.timestamp = timestamp
    }
}

extension Message: Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.text == rhs.text && lhs.timestamp == rhs.timestamp
    }
}
//Keys for CloudKit
struct MessageConstants {
    //we will access the typekey later on in the project
    static let typeKey = "Message"
    //we will mark this as private since we don't need it anywhere else
    fileprivate static let textKey = "Text"
    fileprivate static let timestampKey = "Timestamp"
}
