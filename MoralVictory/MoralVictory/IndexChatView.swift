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

protocol Shakable {
    func shake()
}

extension Shakable where Self: UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 7, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 7, y: self.center.y))

        self.layer.add(animation, forKey: "position")
    }
}

class IndexChatCell: UITableViewCell {
    var talkLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(talkLabel)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView(){
        talkLabel.frame = bounds
        talkLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        talkLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        talkLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
    }

}

class IndexChatView: UIView {
    let disposeBag = DisposeBag()

    var closeFunction: (() -> Void)?
    var moveToIndex: ((Int) -> Void)?

    lazy var profileImageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()

    lazy var nickLabel: UILabel = {
        return UILabel()
    }()

    lazy var closeButton: UIButton = {
        return UIButton()
    }()

    lazy var tableView: UITableView = {
        return UITableView()
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

    var indexChatList: [Talk]? {
        didSet {
            print("didset \(indexChatList?.count)")
            tableView.reloadData()
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
        addSubview(tableView)

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

        tableView.register(IndexChatCell.self, forCellReuseIdentifier: "indexChatCell")
        tableView.autoPinEdge(.top, to: .bottom, of: profileImageView, withOffset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .left)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        tableView.autoPinEdge(toSuperviewEdge: .right)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension IndexChatView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexChatList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "indexChatCell", for: indexPath) as? IndexChatCell,
            let indexItem = indexChatList?[indexPath.row] else {
            return UITableViewCell(style: .default, reuseIdentifier: "indexChatCell")
        }

        cell.talkLabel.text = indexItem.content
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexItem = indexChatList?[indexPath.row] else { return }
        moveToIndex?(indexItem.messageId)
        print("tableView")
    }
}
