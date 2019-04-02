//
//  ChatViewController.swift
//  Chatter
//
//  Created by Harjas Monga on 4/2/19.
//  Copyright © 2019 Harjas Monga. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    var name: String = "Anonymous"
    var messageIndex = 0;
    var messages: [Message] = []
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi));
        self.tableView.separatorStyle = .none
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(checkForNewMessages), userInfo: nil, repeats: true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func checkForNewMessages() {
        ChatService.getMessages(startFrom: messageIndex) { (newMessages) in
            let newIndex: Int = newMessages.last?.id ?? self.messageIndex
            self.messageIndex = newIndex
            self.messages.append(contentsOf: newMessages)
            self.messages.sort(by: { (m1, m2) -> Bool in
                return m1.id ?? 0 > m2.id ?? 0
            })
            self.tableView.reloadData()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
        
    }
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        guard let message = self.messageTextField.text else {return}
        if !message.isEmpty {
            ChatService.sendMessage(name: self.name, message: message)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatTableViewCell
        let message = self.messages[indexPath.row]
        if message.author == self.name {
            if let currentChatCell = tableView.dequeueReusableCell(withIdentifier: "ChatCellFromCurrentUser", for: indexPath) as? ChatTableViewCell {
                cell = currentChatCell
            } else {
                return UITableViewCell()
            }
        } else {
            if let currentChatCell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatTableViewCell {
                cell = currentChatCell
            } else {
                return UITableViewCell()
            }
        }
        cell.messageLabel.text = message.message
        cell.authorLabel.text = message.author
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        return cell
    }
    
}
