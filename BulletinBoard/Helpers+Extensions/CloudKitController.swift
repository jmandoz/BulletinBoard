//
//  CloudKitController.swift
//  BulletinBoard
//
//  Created by Jason Mandozzi on 7/8/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitController {
    //create a singleton so that we can access this elsewhere in the project
    static let shared = CloudKitController()
    
    //creating a Database instance
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    //Crud functions
    
    //Create
    func saveRecordToCloudKit(record: CKRecord, database: CKDatabase, completion: @escaping (Bool) -> Void) {
        //save the record passed in, complete with an optional
        database.save(record) { (_, error) in
            //handle the error
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(false)
            }
            //completion with true
            print(#function)
            completion(true)
        }
    }
    //Read/fetch
    func fetchRecordsOf(type: String, database: CKDatabase, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        //Conditions of query, conditions to be return all found values
        let predicate = NSPredicate(value: true)
        //Defines the record type we want to find, applies our predicate conditions
        let query = CKQuery(recordType: type, predicate: predicate)
        //Performs query, complete with our optional records and optional error
        database.perform(query, inZoneWith: nil) { (records, error) in
            //handle the error
            if let error = error{
            print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(nil, error)
            }
            //complete with records
            if let records = records {
                completion(records, nil)
            }
        }
    }
}
