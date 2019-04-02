//
//  Message.swift
//  Chatter
//
//  Created by Harjas Monga on 4/2/19.
//  Copyright © 2019 Harjas Monga. All rights reserved.
//

import Foundation

struct Message: Codable {
    
    let author: String
    let message: String
    let id: Int?
    let sentTime: String?
    
}
