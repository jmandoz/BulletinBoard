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
    
    //Keys for CloudKit
    
    //we will access the typekey later on in the project
    static let typeKey = "Message"
    private let textKey = "Text"
    private let timestampKey = "Timestamp"
    //we will mark this as private since we don't need it anywhere else
    
    //class properties
    let text: String
    let timestamp: Date
    
    
    //creating an instance of CKRecord
    var cloudKitRecord: CKRecord {
        //Define the record type
        let record = CKRecord(recordType: Message.typeKey)
        //set your key value pairs
        record.setValue(text, forKey: textKey)
        record.setValue(timestamp, forKey: timestampKey)
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
        guard let text = record[textKey] as? String,
        let timestamp = record[timestampKey] as? Date
            else {return nil}
        //initalize the class
        self.text = text
        self.timestamp = timestamp
    }
}

