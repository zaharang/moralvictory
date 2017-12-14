//
//  Chat.swift
//  MoralVictory
//
//  Created by 박현민 on 2017. 12. 13..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit
import Foundation

struct Talk {

    static let images = [#imageLiteral(resourceName: "profile1"), #imageLiteral(resourceName: "profile2"), #imageLiteral(resourceName: "profile3"), #imageLiteral(resourceName: "profile4"), #imageLiteral(resourceName: "profile5"), #imageLiteral(resourceName: "profile6"), #imageLiteral(resourceName: "profile7"), #imageLiteral(resourceName: "profile8")]

    let messageId: Int
    let userId: Int
    let userName: String
    let content: String
    let receivedTime: Date

    init(messageId:Int, userId: Int, userName: String, content: String, receivedTime: Date) {
        self.messageId = messageId
        self.userId = userId
        self.userName = userName
        self.content = content
        self.receivedTime = receivedTime
    }
    
    func getReceivedTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        
        return dateFormatter.string(from: receivedTime)
    }
}
