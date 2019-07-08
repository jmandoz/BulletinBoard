//
//  MessageController.swift
//  BulletinBoard
//
//  Created by Jason Mandozzi on 7/8/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation

class MessageController {
    //Shared instance
    static let shared = MessageController()
    
    //create a notificate 
    let messagesWereUpdatedNotification = Notification.Name("Messages were updated")
    
    //Source of truth
    var messages:[Message] = [] {
        didSet {
            //Create a post for the notification
            NotificationCenter.default.post(name: messagesWereUpdatedNotification, object: nil)
        }
    }
    
    //Crud Functions
    //Create:
                        //wildcard: means that we don't care about an external parameter
    func saveMessageRecord(_ text: String) {
        //init(create) a message
        let messageToSave = Message(text: text)
        //set the database
        let database = CloudKitController.shared.publicDatabase
        
        CloudKitController.shared.saveRecordToCloudKit(record: messageToSave.cloudKitRecord, database: database) { (success) in
            if success {
                print("Succesfully saved Message to CloudKit")
                self.messages.append(messageToSave)
            }
        }
    }
    //Read:
    func fetchMessageRecords() {
        let database = CloudKitController.shared.publicDatabase
        CloudKitController.shared.fetchRecordsOf(type: MessageConstants.typeKey, database: database) { (records, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
            }
            guard let foundRecords = records else {return}
            //iterates through foundRecords, init Messages from the values that can init a Message, creating a new array from successes
            let messages = foundRecords.compactMap({Message(record: $0)})
            //set source of truth
            self.messages = messages
        }
    }
    //Update:
    
    //Delete:
//    func deleteMessageRecord() {
//        let database = CloudKitController.shared.publicDatabase
//        
//    }
//    
}
