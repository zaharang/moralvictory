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
    
    override func setupLayoutConstraint(withTalkItem talkItem: Talk) {
        talkLabelGroup.autoPinEdge(.left, to: .left, of: contentView)
        talkLabelGroup.autoPinEdge(.right, to: .right, of: contentView, withOffset: -5)
        talkLabelGroup.autoPinEdge(.top, to: .top, of: contentView, withOffset: 10)
        talkLabelGroup.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -10)
        
        talkLabelBaloonGroup.autoPinEdge(.right, to: .right, of: talkLabelGroup)
        talkLabelBaloonGroup.autoPinEdge(.top, to: .bottom, of: profileNameLabel, withOffset: 5)
        talkLabelBaloonGroup.autoPinEdge(.bottom, to: .bottom, of: talkLabelGroup)
        
        receivedTimeLabel.autoPinEdge(.left, to: .right, of: secretUserProfileImageView, withOffset: 5)
        receivedTimeLabel.autoPinEdge(.right, to: .left, of: talkLabelBaloonGroup, withOffset: -5)
        receivedTimeLabel.autoPinEdge(.bottom, to: .bottom, of: talkLabelGroup)
        
        readLabel.autoPinEdge(.left, to: .left, of: receivedTimeLabel)
        readLabel.autoPinEdge(.bottom, to: .top, of: receivedTimeLabel)
        
        secretUserProfileImageView.autoPinEdge(.right, to: .left, of: receivedTimeLabel, withOffset: -5)
        secretUserProfileImageView.autoPinEdge(.bottom, to: .bottom, of: talkLabelGroup, withOffset: 5)
        secretUserProfileImageView.autoSetDimension(.width, toSize: secretProfileImageViewSize)
        secretUserProfileImageView.autoSetDimension(.height, toSize: secretProfileImageViewSize)
        
        receivedTimeLabel.layoutIfNeeded()
        let contentStringExpectRect = NSString(string: talkItem.content).boundingRect(with: CGSize(width: frame.width - receivedTimeLabel.frame.width - gapWithEdge - secretProfileImageViewSize - 5, height: CGFloat.greatestFiniteMagnitude/2), options: [NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font:talkLabelFont], context: nil)
        // height 16.707... is one line
        if contentStringExpectRect.height < 17 {
        }
        else {
            secretUserProfileImageView.autoPinEdge(.left, to: .left, of: talkLabelGroup, withOffset: gapWithEdge)
        }
        
        talkLabel.autoPinEdge(.left, to: .left, of: talkLabelBaloonGroup, withOffset: 15)
        talkLabel.autoPinEdge(.right, to: .right, of: talkLabelBaloonGroup, withOffset: -15)
        talkLabel.autoPinEdge(.top, to: .top, of: talkLabelBaloonGroup, withOffset: 10)
        talkLabel.autoPinEdge(.bottom, to: .bottom, of: talkLabelBaloonGroup, withOffset: -10)
        
        talkLabelImageView.autoPinEdge(.left, to: .left, of: talkLabelBaloonGroup)
        talkLabelImageView.autoPinEdge(.right, to: .right, of: talkLabelBaloonGroup)
        talkLabelImageView.autoPinEdge(.top, to: .top, of: talkLabelBaloonGroup)
        talkLabelImageView.autoPinEdge(.bottom, to: .bottom, of: talkLabelBaloonGroup)
    }
}
