//
//  Chat.swift
//  MoralVictory
//
//  Created by 박현민 on 2017. 12. 13..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import Foundation

struct Talk {
    let userId: Int
    let userName: String
    let content: String

    init(userId: Int, userName: String, content: String) {
        self.userId = userId
        self.userName = userName
        self.content = content
    }
}
