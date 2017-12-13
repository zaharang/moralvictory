//
//  IndexChatView.swift
//  MoralVictory
//
//  Created by 박현민 on 2017. 12. 13..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class IndexChatView: UIView {
    let disposeBag = DisposeBag()

    var closeFunction: (() -> Void)?

    lazy var profileImageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()

    lazy var nickLabel: UILabel = {
        return UILabel()
    }()

    lazy var closeButton: UIButton = {
        return UIButton()
    }()

    var nick: String? {
        didSet{
            nickLabel.text = nick
        }
    }

    var profileImage: UIImage? {
        didSet {
            profileImageView.image = profileImage
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView(){
        backgroundColor = .red
        addSubview(closeButton)
        addSubview(profileImageView)
        addSubview(nickLabel)

        closeButton.autoSetDimensions(to: CGSize(width: 32, height: 32))
        closeButton.backgroundColor = .blue
        closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
        closeButton.rx.tap.bind{ [weak self] _ in
            self?.closeFunction?()
        }.disposed(by: disposeBag)

        profileImageView.autoSetDimensions(to: CGSize(width: 32, height: 32))
        profileImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
        profileImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)

        nickLabel.autoPinEdge(.left, to: .right, of: profileImageView, withOffset: 10)
        nickLabel.autoAlignAxis(.horizontal, toSameAxisOf: profileImageView)
        nickLabel.autoPinEdge(.right, to: .left, of: closeButton)
    }

}
