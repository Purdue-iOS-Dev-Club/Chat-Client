//
//  ChatService.swift
//  Chatter
//
//  Created by Harjas Monga on 4/2/19.
//  Copyright © 2019 Harjas Monga. All rights reserved.
//

import Foundation

class ChatService {
    
    static let baseUrl = URL(string: "http://localhost:8080")!
    
    static func getMessages(startFrom id: Int, success: @escaping ([Message]) -> ()) {
        let url = ChatService.baseUrl.appendingPathComponent("messages/\(id)")
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let unwrappedData = data else {return}
            let decoder = JSONDecoder()
            guard let newMessages = try? decoder.decode([Message].self, from: unwrappedData) else {return}
            DispatchQueue.main.async {
                success(newMessages)
            }
        }
        task.resume()
    }
    
    static func sendMessage(name: String, message: String) {
        let url = ChatService.baseUrl.appendingPathComponent("messages")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        let messageBody = Message(author: name, message: message, id: nil, sentTime: nil)
        let encoder = JSONEncoder()
        guard let messageData = try? encoder.encode(messageBody) else {return}
        request.httpBody = messageData
        print("sendiing")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            // do nothing
        }
        task.resume()
    }
    
}
