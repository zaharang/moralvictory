//
//  GroupChatListCellMeSecret.swift
//  MoralVictory
//
//  Created by 김도윤 on 2017. 12. 14..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit

class GroupChatListCellMeSecret: GroupChatListCellMe {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        talkLabel.textColor = UIColor.blue
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
