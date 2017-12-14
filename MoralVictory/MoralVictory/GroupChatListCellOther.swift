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

        let img = UIImage(named: "baloon_left")
        let imgInsets : UIEdgeInsets = UIEdgeInsetsMake(20, 30, 20, 30)

        talkLabelImageView.image = img?.resizableImage(withCapInsets: imgInsets, resizingMode: .stretch)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayoutConstraint(withTalkItem talkItem: Talk) {
        
        let contentStringExpectRect = NSString(string: talkItem.content).boundingRect(with: CGSize(width: frame.width - imageViewSize - 10, height: CGFloat.greatestFiniteMagnitude/2), options: [NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font:talkLabelFont], context: nil)
        
        profileImageView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 5)
        profileImageView.autoSetDimension(.width, toSize: imageViewSize)
        profileImageView.autoSetDimension(.height, toSize: imageViewSize)
        profileImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        talkLabelGroup.autoPinEdge(.left, to: .right, of: profileImageView, withOffset: 5)
        talkLabelGroup.autoPinEdge(.right, to: .right, of: contentView)
        talkLabelGroup.autoPinEdge(.top, to: .top, of: contentView, withOffset: 10)
        talkLabelGroup.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -10)
        
        profileNameLabel.autoPinEdge(.left, to: .left, of: talkLabelGroup)
        profileNameLabel.autoPinEdge(.right, to: .right, of: talkLabelGroup)
        profileNameLabel.autoPinEdge(.top, to: .top, of: talkLabelGroup)
        
        // height 16.707... is one line
        if contentStringExpectRect.height < 17 {
            talkLabelBaloonGroup.autoPinEdge(.left, to: .left, of: talkLabelGroup)
            talkLabelBaloonGroup.autoPinEdge(.top, to: .bottom, of: profileNameLabel, withOffset: 5)
            talkLabelBaloonGroup.autoPinEdge(.bottom, to: .bottom, of: talkLabelGroup)
        }
        else {
            talkLabelBaloonGroup.autoPinEdge(.left, to: .left, of: talkLabelGroup)
            talkLabelBaloonGroup.autoPinEdge(.right, to: .right, of: talkLabelGroup)
            talkLabelBaloonGroup.autoPinEdge(.top, to: .bottom, of: profileNameLabel, withOffset: 5)
            talkLabelBaloonGroup.autoPinEdge(.bottom, to: .bottom, of: talkLabelGroup)
        }
        
        talkLabel.autoPinEdge(.left, to: .left, of: talkLabelBaloonGroup, withOffset: 10)
        talkLabel.autoPinEdge(.right, to: .right, of: talkLabelBaloonGroup, withOffset: -10)
        talkLabel.autoPinEdge(.top, to: .top, of: talkLabelBaloonGroup, withOffset: 5)
        talkLabel.autoPinEdge(.bottom, to: .bottom, of: talkLabelBaloonGroup, withOffset: -5)
        
        talkLabelImageView.autoPinEdge(.left, to: .left, of: talkLabelBaloonGroup)
        talkLabelImageView.autoPinEdge(.right, to: .right, of: talkLabelBaloonGroup)
        talkLabelImageView.autoPinEdge(.top, to: .top, of: talkLabelBaloonGroup)
        talkLabelImageView.autoPinEdge(.bottom, to: .bottom, of: talkLabelBaloonGroup)
    }

}
