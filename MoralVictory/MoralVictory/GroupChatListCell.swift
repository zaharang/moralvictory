//
//  GroupChatListCell.swift
//  MoralVictory
//
//  Created by USER on 2017. 12. 14..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit

let profileNameFont = UIFont.systemFont(ofSize: 10)
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
    let baloonImgInsets : UIEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20)

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none

        talkLabelGroup.addSubview(profileNameLabel)

        talkLabelBaloonGroup.addSubview(talkLabelImageView)
        talkLabelBaloonGroup.addSubview(talkLabel)
        talkLabelGroup.addSubview(talkLabelBaloonGroup)

        self.contentView.addSubview(talkLabelGroup)

        self.contentView.addSubview(profileImageView)
        self.contentView.clipsToBounds = true
        addSwipeDelegate()

        profileNameLabel.numberOfLines = 0
        profileNameLabel.lineBreakMode = .byWordWrapping

        talkLabel.numberOfLines = 0
        talkLabel.lineBreakMode = .byWordWrapping
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
