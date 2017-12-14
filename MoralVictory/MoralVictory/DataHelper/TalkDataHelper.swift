//
//  TalkDataHelper.swift
//  MoralVictory
//
//  Created by 박현민 on 2017. 12. 13..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import Foundation

let meUser = (0, "testMe")
let secretTestUser = (1, "Zaharang")

class TalkDataHelper {

    static let shared: TalkDataHelper = TalkDataHelper()

    private let COUNT_DUMP = 100

    private init() {

    }

    let dumpUsers: [(Int, String)] = [meUser, secretTestUser, (2, "Hermetic"), (3, "Shrimp Chip"), (4,"Woosom")]

    let scripts = [
    "So, there you are... I've been upstairs looking all over for you...",
    "Oh, I thought you were already on the high seas.",
        "No, not yet, Dad.",
        "Isn't it fashionable any more to put on a sailor's cap with the name of the yacht? ",
        "No, Dad, it isn't.",
        "And how long will you be away? ",
        "Four or five days.",
        "Oh, very well. I'll just spend the weekend alone by myself and take a little rest. I should be used to it by now.",
        "Used to what?",
        "To the fact of my retirement, not only as a diplomat but also as a father.",
        "But how could you say such a thing?",
        "Because it's true. After thirty years -- not having ever spoken the truth to anyone, I should at least allow myself to do so with my own daughter. ",
        "And have you any other truths to tell me? ",
        "You already know what they are.",
        "You mean Sandro, don't you?  Well, I beg of you, please, spare me that. Goodbye, Dad.",
        "That type will never marry you, my child.",
        "Up until now, Dad, I've been the one who hasn't wanted to marry him.",
        "It's the same thing. Goodbye, dear.",
        "Have you been waiting long? You'll have to excuse me.",
        "Please hurry, Alvaro. We're late.",
        "I'll wait for you here.",
        "But where are you going?",
        "I'm thirsty.",
        "If I had a man waiting for me for half an hour and whom I hadn't seen for a month ",
        "You know, I could just as well go without seeing him today."
    ]


    func makeDumpList() -> [Talk] {
        var talkList: [Talk] = []

        for i in 0..<scripts.count {
            let randIdx = Int(arc4random_uniform(4)) + 1
            talkList.append(Talk(userId: dumpUsers[randIdx].0, userName: dumpUsers[randIdx].1, content: scripts[i], receivedTime: Date()))
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
