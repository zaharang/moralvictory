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
    lazy var talkLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var talkBackView: UIView = {
        let view = UIView()
        return view
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(talkBackView)
        talkBackView.addSubview(talkLabel)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView() {
        talkBackView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        talkBackView.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        talkBackView.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
        talkBackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5)
        talkBackView.layer.masksToBounds = true
        talkBackView.layer.backgroundColor = UIColor.white.cgColor
        talkBackView.layer.cornerRadius = 5

        talkLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        talkLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        talkLabel.autoPinEdge(toSuperviewEdge: .top)
        talkLabel.autoPinEdge(toSuperviewEdge: .bottom)

        backgroundColor = .clear
    }

}

class IndexChatView: UIView {
    let disposeBag = DisposeBag()

    var closeFunction: (() -> Void)?
    var moveToIndex: ((Int) -> Void)?

    lazy var innerPanel: UIView = {
        return UIView(frame: .zero)
    }()

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
            tableView.reloadData()
            scrollToMessage()
        }
    }

    var messageId: Int = 0

    let bgColor = UIColor(red: 0.4, green: 0.52, blue: 0.72, alpha: 1.0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView() {
        backgroundColor = bgColor
        addSubview(innerPanel)
        innerPanel.addSubview(closeButton)
        innerPanel.addSubview(profileImageView)
        innerPanel.addSubview(nickLabel)
        innerPanel.addSubview(tableView)

        innerPanel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))

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
        tableView.backgroundColor = .clear
        tableView.autoPinEdge(.top, to: .bottom, of: profileImageView, withOffset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .left)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        tableView.autoPinEdge(toSuperviewEdge: .right)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

    func scrollToMessage(){
        guard let chatList = indexChatList else {
            return
        }
        var destnationIndex = 0

        for i in 0..<chatList.count {
            if chatList[i].messageId == messageId {
                destnationIndex = i
                break
            }
        }
        tableView.scrollToRow(at: IndexPath(row: destnationIndex, section: 0), at: .bottom, animated: false)
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
    }
}
