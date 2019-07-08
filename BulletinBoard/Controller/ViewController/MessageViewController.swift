//
//  MessageViewController.swift
//  BulletinBoard
//
//  Created by Jason Mandozzi on 7/8/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews), name: MessageController.shared.messagesWereUpdatedNotification, object: nil)
        
        MessageController.shared.fetchMessageRecords()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: MessageController.shared.messagesWereUpdatedNotification, object: nil)
    }
    
    @objc func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        guard let messageText = textField.text, messageText != "" else {return}
        
        MessageController.shared.saveMessageRecord(messageText)
        textField.text = ""
        
        
    }
    
}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        let message = MessageController.shared.messages[indexPath.row]
        
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.timestamp.formatDate()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.shared.messages.count
    }
}
