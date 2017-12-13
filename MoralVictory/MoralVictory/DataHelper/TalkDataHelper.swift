//
//  TalkDataHelper.swift
//  MoralVictory
//
//  Created by 박현민 on 2017. 12. 13..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import Foundation

class TalkDataHelper {

    static let shared: TalkDataHelper = TalkDataHelper()

    private let COUNT_DUMP = 200

    private init() {

    }

    let dumpUsers: [(Int, String)] = [(0,"Loaker"), (1, "ShrimpChips"), (2, "French Pie"), (3, "ConnectOne"), (4,"Beer"), (5, "Soju"), (6, "PaperCup")]

    func makeDumpList() -> [Talk] {
        var talkList: [Talk] = []

        for _ in 0..<COUNT_DUMP {
            let randIdx = Int(arc4random_uniform(UInt32(dumpUsers.count)))
            let contentLength = Int(arc4random_uniform(15)) + 3
            talkList.append(Talk(userId: dumpUsers[randIdx].0, userName: dumpUsers[randIdx].1, content: randomString(length: contentLength)))
        }

        return talkList
    }

    func getTalkList() -> [Talk] {
        return makeDumpList()
    }

    private func randomString(length: Int) -> String {

        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
}
