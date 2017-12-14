//
//  GroupChatListCellOther.swift
//  MoralVictory
//
//  Created by USER on 2017. 12. 14..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit

class GroupChatListCellOther: GroupChatListCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        profileImageView.autoPinEdge(.right, to: .right, of: contentView, withOffset: 20)
        profileImageView.autoSetDimension(.width, toSize: imageViewSize)
        profileImageView.autoSetDimension(.height, toSize: imageViewSize)
        profileImageView.autoAlignAxis(toSuperviewAxis: .horizontal)

        profileNameLabel.autoPinEdge(.right, to: .left, of: profileImageView, withOffset: 20)
        profileNameLabel.autoPinEdge(.left, to: .left, of: contentView)
        profileNameLabel.autoPinEdge(.top, to: .top, of: contentView)

        talkLabel.autoPinEdge(.left, to: .right, of: profileImageView, withOffset: 20)
        talkLabel.autoPinEdge(.right, to: .right, of: contentView)
        talkLabel.autoPinEdge(.top, to: .bottom, of: profileNameLabel)
        talkLabel.autoPinEdge(.bottom, to: .bottom, of: contentView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
