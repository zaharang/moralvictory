//
//  GroupChatListCell.swift
//  MoralVictory
//
//  Created by USER on 2017. 12. 14..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit

class GroupChatListCell: UITableViewCell, Shakable {
    var delegate: SwipeDelegate?

    var talkLabelGroup = UIView()
    lazy var talkLabelImageView: UIImageView = {
        let imgView = UIImageView()

        imgView.isUserInteractionEnabled = true
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 6

        return imgView
    }()
    var talkLabel = UILabel()
    var profileNameLabel = UILabel()
    var profileImageView = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        //        self.contentView.addSubview(talkLabel)


        talkLabelGroup.addSubview(talkLabelImageView)
        talkLabelGroup.addSubview(talkLabel)
        self.contentView.addSubview(talkLabelGroup)

        contentView.addSubview(profileNameLabel)
        self.contentView.addSubview(profileImageView)
        self.contentView.clipsToBounds = true
        addSwipeDelegate()

        profileNameLabel.numberOfLines = 0
        profileNameLabel.lineBreakMode = .byWordWrapping

        talkLabel.numberOfLines = 0
        talkLabel.lineBreakMode = .byWordWrapping

        profileImageView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 20)
        profileImageView.autoSetDimension(.width, toSize: imageViewSize)
        profileImageView.autoSetDimension(.height, toSize: imageViewSize)
        profileImageView.autoAlignAxis(toSuperviewAxis: .horizontal)

        profileNameLabel.autoPinEdge(.left, to: .right, of: profileImageView, withOffset: 20)
        profileNameLabel.autoPinEdge(.right, to: .right, of: contentView)
        profileNameLabel.autoPinEdge(.top, to: .top, of: contentView)

        talkLabel.autoPinEdge(.left, to: .right, of: profileImageView, withOffset: 20)
        talkLabel.autoPinEdge(.right, to: .right, of: contentView)
        talkLabel.autoPinEdge(.top, to: .bottom, of: profileNameLabel)
        talkLabel.autoPinEdge(.bottom, to: .bottom, of: contentView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()


        //        profileImageView.frame = CGRect(x: 20, y: (frame.height - imageViewSize)/2, width: imageViewSize, height: imageViewSize)
        //        let textViewX = profileImageView.frame.origin.x + imageViewSize + 20
        //
        //        let imgGap = CGFloat(5)
        //        talkLabelGroup.frame = CGRect(x: textViewX, y: 0, width: frame.width - textViewX, height: frame.height)
        //        talkLabelImageView.frame = CGRect(x: 0, y: imgGap,
        //                                          width: talkLabelGroup.frame.width,
        //                                          height: talkLabelGroup.frame.height - imgGap*2)
        //
        //        let textGap = CGFloat(10)
        //        talkLabel.frame = CGRect(x: textGap, y: textGap,
        //                                 width: talkLabelGroup.frame.width - textGap*2,
        //                                 height: talkLabelGroup.frame.height - textGap*2)
        //
        //        talkLabel.backgroundColor = UIColor(white: 0, alpha: 0)
        //
        let img = UIImage(named: "baloon_left")
        let imgInsets : UIEdgeInsets = UIEdgeInsetsMake(20, 30, 20, 30)

        talkLabelImageView.image = img?.resizableImage(withCapInsets: imgInsets, resizingMode: .stretch)
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
