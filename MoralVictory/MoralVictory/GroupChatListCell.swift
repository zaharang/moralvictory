//
//  GroupChatListCell.swift
//  MoralVictory
//
//  Created by USER on 2017. 12. 14..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit

let profileNameFont = UIFont.systemFont(ofSize: 10)
let receivedTimeFont = UIFont.systemFont(ofSize: 10)
let readFont = UIFont.systemFont(ofSize: 10)
let talkLabelFont = UIFont.systemFont(ofSize: 14)

class GroupChatListCell: UITableViewCell, Shakable {
    var delegate: SwipeDelegate?

    var talkLabelGroup = UIView()
    var talkLabelBaloonGroup = UIView()
    lazy var talkLabelImageView: UIImageView = {
        let imgView = UIImageView()

        imgView.isUserInteractionEnabled = true
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 6

        return imgView
    }()
    var talkLabel = UILabel()
    lazy var profileNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white

        return label;
    }()
    var profileImageView = UIImageView()
    var receivedTimeLabel = UILabel()
    var readLabel = UILabel()
    
    let baloonImgInsets : UIEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20)

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none

        talkLabelGroup.addSubview(profileNameLabel)

        talkLabelBaloonGroup.addSubview(talkLabelImageView)
        talkLabelBaloonGroup.addSubview(talkLabel)
        talkLabelGroup.addSubview(talkLabelBaloonGroup)
        talkLabelGroup.addSubview(receivedTimeLabel)
        talkLabelGroup.addSubview(readLabel)

        self.contentView.addSubview(talkLabelGroup)

        self.contentView.addSubview(profileImageView)
        self.contentView.clipsToBounds = true
        addSwipeDelegate()

        profileNameLabel.numberOfLines = 0
        profileNameLabel.font = profileNameFont
        profileNameLabel.lineBreakMode = .byWordWrapping

        talkLabel.numberOfLines = 0
        talkLabel.font = talkLabelFont
        talkLabel.lineBreakMode = .byWordWrapping
        
        readLabel.numberOfLines = 1
        readLabel.text = "읽음 4"
        readLabel.font = readFont
        
        receivedTimeLabel.numberOfLines = 1
        receivedTimeLabel.font = receivedTimeFont
        
        backgroundColor = UIColor(red: 0.4, green: 0.52, blue: 0.72, alpha: 1.0)
    }
    
    func setupLayoutConstraint(withTalkItem talkItem: Talk) {
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func addSwipeDelegate() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeLeft.direction = .left
        swipeRight.direction = .right
        contentView.gestureRecognizers = [swipeLeft, swipeRight]
    }

    @objc func handleSwipeLeft() {
        delegate?.swipe(cell: self ,direction: .left)
    }

    @objc func handleSwipeRight() {
        delegate?.swipe(cell: self, direction: .right)
    }
}
