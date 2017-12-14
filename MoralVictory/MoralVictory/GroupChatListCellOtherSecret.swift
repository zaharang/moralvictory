//
//  GroupChatListCellOtherSecret.swift
//  MoralVictory
//
//  Created by 김도윤 on 2017. 12. 14..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit

class GroupChatListCellOtherSecret: GroupChatListCellOther {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let img = UIImage(named: "baloon_right")?.withRenderingMode(.alwaysTemplate)
        talkLabelImageView.image = img?.resizableImage(withCapInsets: baloonImgInsets, resizingMode: .stretch)
        talkLabelImageView.tintColor = UIColor.black
        talkLabelImageView.alpha = 0.7
        
        talkLabel.textColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
