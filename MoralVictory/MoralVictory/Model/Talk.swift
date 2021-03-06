//
//  Chat.swift
//  MoralVictory
//
//  Created by 박현민 on 2017. 12. 13..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit
import Foundation


class Counter {
    private var queue = DispatchQueue(label: "your.queue.identifier")
    private (set) var value: Int = -1

    func incrementAndGet() -> Int {
        queue.sync {
            value += 1
        }
        return value
    }
}

struct Talk {
    static let counter = Counter()

    static let images = [#imageLiteral(resourceName: "profile1"), #imageLiteral(resourceName: "profile2"), #imageLiteral(resourceName: "profile3"), #imageLiteral(resourceName: "profile4"), #imageLiteral(resourceName: "profile5"), #imageLiteral(resourceName: "profile6"), #imageLiteral(resourceName: "profile7"), #imageLiteral(resourceName: "profile8")]

    let messageId: Int
    let userId: Int
    let userName: String
    let content: String
    let receivedTime: Date
    let isSecret: Bool

    init(userId: Int, userName: String, content: String, receivedTime: Date, isSecret: Bool = false) {
        self.messageId = Talk.counter.incrementAndGet()
        self.userId = userId
        self.userName = userName
        self.content = content
        self.receivedTime = receivedTime
        self.isSecret = isSecret
    }
    
    func getReceivedTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: receivedTime)
    }
}
