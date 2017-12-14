//
//  GroupChatListCellMe.swift
//  MoralVictory
//
//  Created by USER on 2017. 12. 14..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit

class GroupChatListCellMe: GroupChatListCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        talkLabelGroup.autoPinEdge(.left, to: .left, of: contentView)
        talkLabelGroup.autoPinEdge(.right, to: .right, of: contentView, withOffset: 5)
        talkLabelGroup.autoPinEdge(.top, to: .top, of: contentView)
        talkLabelGroup.autoPinEdge(.bottom, to: .bottom, of: contentView)
        
        talkLabelBaloonGroup.autoPinEdge(.left, to: .left, of: talkLabelGroup)
        talkLabelBaloonGroup.autoPinEdge(.right, to: .right, of: talkLabelGroup)
        talkLabelBaloonGroup.autoPinEdge(.top, to: .top, of: talkLabelGroup)
        talkLabelBaloonGroup.autoPinEdge(.bottom, to: .bottom, of: talkLabelGroup)

        talkLabel.autoPinEdge(.left, to: .left, of: talkLabelBaloonGroup, withOffset: 10)
        talkLabel.autoPinEdge(.right, to: .right, of: talkLabelBaloonGroup, withOffset: -10)
        talkLabel.autoPinEdge(.top, to: .top, of: talkLabelBaloonGroup)
        talkLabel.autoPinEdge(.bottom, to: .bottom, of: talkLabelBaloonGroup)
        
        talkLabelImageView.autoPinEdge(.left, to: .left, of: talkLabelBaloonGroup)
        talkLabelImageView.autoPinEdge(.right, to: .right, of: talkLabelBaloonGroup)
        talkLabelImageView.autoPinEdge(.top, to: .top, of: talkLabelBaloonGroup)
        talkLabelImageView.autoPinEdge(.bottom, to: .bottom, of: talkLabelBaloonGroup)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
