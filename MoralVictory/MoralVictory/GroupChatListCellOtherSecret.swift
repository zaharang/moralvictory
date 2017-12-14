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
        
        let img = UIImage(named: "baloon_left")?.withRenderingMode(.alwaysTemplate)
        talkLabelImageView.image = img?.resizableImage(withCapInsets: baloonImgInsets, resizingMode: .stretch)
        talkLabelImageView.tintColor = UIColor.black
        talkLabelImageView.alpha = 0.7
        
        talkLabel.textColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setupLayoutConstraint(withTalkItem talkItem: Talk) {
        profileImageView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 5)
        profileImageView.autoPinEdge(.top, to: .top, of: talkLabelGroup)
        profileImageView.autoSetDimension(.width, toSize: imageViewSize)
        profileImageView.autoSetDimension(.height, toSize: imageViewSize)
        
        talkLabelGroup.autoPinEdge(.left, to: .right, of: profileImageView, withOffset: 5)
        talkLabelGroup.autoPinEdge(.right, to: .right, of: contentView, withOffset: -50)
        talkLabelGroup.autoPinEdge(.top, to: .top, of: contentView, withOffset: 10)
        talkLabelGroup.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -10)
        
        profileNameLabel.autoPinEdge(.left, to: .left, of: talkLabelGroup)
        profileNameLabel.autoPinEdge(.right, to: .right, of: talkLabelGroup)
        profileNameLabel.autoPinEdge(.top, to: .top, of: talkLabelGroup)
        
        talkLabelBaloonGroup.autoPinEdge(.left, to: .left, of: talkLabelGroup)
        talkLabelBaloonGroup.autoPinEdge(.top, to: .bottom, of: profileNameLabel, withOffset: 5)
        talkLabelBaloonGroup.autoPinEdge(.bottom, to: .bottom, of: talkLabelGroup)
        
        receivedTimeLabel.autoPinEdge(.left, to: .right, of: talkLabelBaloonGroup)
        receivedTimeLabel.autoPinEdge(.bottom, to: .bottom, of: talkLabelGroup)
        
        secretUserProfileImageView.autoPinEdge(.left, to: .right, of: receivedTimeLabel, withOffset: 5)
        secretUserProfileImageView.autoPinEdge(.bottom, to: .bottom, of: talkLabelGroup, withOffset: 5)
        secretUserProfileImageView.autoSetDimension(.width, toSize: secretProfileImageViewSize)
        secretUserProfileImageView.autoSetDimension(.height, toSize: secretProfileImageViewSize)
        
        receivedTimeLabel.layoutIfNeeded()
        let contentStringExpectRect = NSString(string: talkItem.content).boundingRect(with: CGSize(width: frame.width - imageViewSize - 10 - gapWithEdge - secretProfileImageViewSize, height: CGFloat.greatestFiniteMagnitude/2), options: [NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font:talkLabelFont], context: nil)
        
        // height 16.707... is one line
        if contentStringExpectRect.height < 17 {
        }
        else {
            secretUserProfileImageView.autoPinEdge(.right, to: .right, of: talkLabelGroup, withOffset: 10)
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
