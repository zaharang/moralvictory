//
//  GroupChatListViewController.swift
//  MoralVictory
//
//  Created by 김도윤 on 2017. 12. 13..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit
import PureLayout

let topBarHeight = CGFloat(87)
let bottomBarHeight = CGFloat(50)
let imageViewSize = CGFloat(40)

enum SwipeDirection: Int{
    case left = 0
    case right
}

protocol SwipeDelegate {
    func swipe(cell: UITableViewCell, direction: SwipeDirection)
}

class GroupChatListViewController: UIViewController {

    let topChatListHeight = UIScreen.main.bounds.height / 2 - 30

    var talkList: [Talk]?

    var ignoreLists: [Int] = []
    
    var tableView:UITableView!
    var bottomBarView:UIView!
    var bottomBarBackgroundImageView:UIImageView!
    var topBarView:UIImageView!
    var textField:UITextField = {
        let view = UITextField(frame: .zero)
        return view
    }()

    var topChatListViewContraint: NSLayoutConstraint?

    lazy var chatListView: IndexChatView = {
        return IndexChatView(frame: .zero)
    }()

    var isBaloonMe: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        topChatListViewContraint = tableView.autoPinEdge(toSuperviewEdge: .top, withInset: topBarHeight)
        tableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: bottomBarHeight)
        tableView.autoPinEdge(toSuperviewEdge: .left)
        tableView.autoPinEdge(toSuperviewEdge: .right)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.4, green: 0.52, blue: 0.72, alpha: 1.0)
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(GroupChatListCell.self, forCellReuseIdentifier: "GroupChatListCell")

        fetchData()

        self.view.addSubview(chatListView)

        chatListView.autoPinEdge(.bottom, to: .top, of: tableView)
        chatListView.autoPinEdge(toSuperviewEdge: .left)
        chatListView.autoPinEdge(toSuperviewEdge: .right)
        chatListView.autoSetDimension(.height, toSize: topChatListHeight)
        chatListView.closeFunction = closeTopView
        chatListView.moveToIndex = moveToIndex

        bottomBarView = UIView(frame: .zero)
        self.view.addSubview(bottomBarView)
        bottomBarView.autoPinEdge(.left, to: .left, of: view)
        bottomBarView.autoPinEdge(.right, to: .right, of: view)
        bottomBarView.autoPinEdge(.bottom, to: .bottom, of: view)
        bottomBarView.autoSetDimension(.height, toSize: bottomBarHeight)
        
        bottomBarBackgroundImageView = UIImageView(image: UIImage(named: "bottom_bar"))
        self.bottomBarView.addSubview(bottomBarBackgroundImageView)
        bottomBarView.autoPinEdge(.left, to: .left, of: view)
        bottomBarView.autoPinEdge(.right, to: .right, of: view)
        bottomBarView.autoPinEdge(.top, to: .top, of: bottomBarView)
        bottomBarView.autoPinEdge(.bottom, to: .bottom, of: bottomBarView)
        
        self.bottomBarView.addSubview(textField)
        textField.autoPinEdge(.left, to: .left, of: bottomBarView, withOffset: 140)
        textField.autoPinEdge(.right, to: .right, of: bottomBarView, withOffset: -60)
        textField.autoPinEdge(.top, to: .top, of: bottomBarView)
        textField.autoPinEdge(.bottom, to: .bottom, of: bottomBarView)
        textField.delegate = self

        topBarView = UIImageView(image: UIImage(named: "navi_bar"))
        topBarView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: topBarHeight)
        self.view.addSubview(topBarView)
    }

    func fetchData() {
        talkList = TalkDataHelper.shared.getTalkList()
        tableView.reloadData()
    }

    func closeTopView() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.topChatListViewContraint?.constant = topBarHeight
            strongSelf.view.layoutIfNeeded()
        }
    }

    func moveToIndex(index: Int) {
        let indexPath = IndexPath(row:index, section: 0)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            self?.shakeCell(indexPath: indexPath)
        }

    }

    func shakeCell(indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? GroupChatListCell {
            cell.shake()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension GroupChatListViewController: UITextFieldDelegate {
    
}

extension GroupChatListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let talkItem = talkList?[indexPath.row] else {
            return 0
        }

        return ignoreLists.contains(talkItem.userId) ? 0 : UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talkList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GroupChatListCell

        /////////////////////////////////////////////////////////////////
        // for debugging
//        let randomNo: UInt32 = arc4random_uniform(2);
//        if randomNo == 1 {
//            isBaloonMe = true
//        } else {
//            isBaloonMe = false
//        }
        /////////////////////////////////////////////////////////////////

        if isBaloonMe == true {
            cell = GroupChatListCellMe(style: .default, reuseIdentifier: "GroupChatListCell")
            // debugging
//            cell.isSecretTalk = true
        } else {
            cell = GroupChatListCellOther(style: .default, reuseIdentifier: "GroupChatListCell")
            // debugging
//            cell.isSecretTalk = false
        }

        guard let talkItem = talkList?[indexPath.row] else {
            return cell
        }
        
        cell.setupLayoutConstraint(withTalkItem: talkItem)

        cell.profileImageView.image = ignoreLists.contains(talkItem.userId) ? nil : Talk.images[talkItem.userId]
        cell.receivedTimeLabel.text = talkItem.getReceivedTimeString()
        cell.profileNameLabel.text = talkItem.userName
        cell.talkLabel.text = talkItem.content
        if cell.isSecretTalk == true {
            cell.talkLabel.textColor = UIColor.blue
        } else {
            cell.talkLabel.textColor = UIColor.black
        }
        cell.backgroundColor = UIColor(red: 0.4, green: 0.52, blue: 0.72, alpha: 1.0)

        cell.delegate = self
        return cell
    }
}

extension GroupChatListViewController: SwipeDelegate {
    func swipe(cell: UITableViewCell, direction: SwipeDirection) {

        switch direction {
        case .left:
            showIgnoreSheet(index: tableView.indexPath(for: cell)?.row ?? 0)
        default:
            showIndexView(index: tableView.indexPath(for: cell)?.row ?? 0)
        }
    }

    func showIgnoreSheet(index: Int) {

        guard let talkItem = talkList?[index] else { return }

        let alertController = UIAlertController(title: "Ignore", message: "How much ignore msg from \(talkItem.userName)", preferredStyle: .actionSheet)

        let lv1Button = UIAlertAction(title: "5 Minutes", style: .default, handler: {[weak self] (action) -> Void in
            self?.ignoreUser(id: talkItem.userId)
        })

        let lv2Button = UIAlertAction(title: "1 Hour", style: .default, handler: {[weak self] (action) -> Void in
            self?.ignoreUser(id: talkItem.userId)
        })

        let foreverButton = UIAlertAction(title: "Forever", style: .destructive, handler: {[weak self] (action) -> Void in
            self?.ignoreUser(id: talkItem.userId)
        })

        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })


        alertController.addAction(lv1Button)
        alertController.addAction(lv2Button)
        alertController.addAction(foreverButton)
        alertController.addAction(cancelButton)

        present(alertController, animated: true, completion: nil)
    }

    func showIndexView(index: Int){
        guard let talkItem = talkList?[index] else { return }
        chatListView.messageId = talkItem.messageId
        chatListView.nick = talkItem.userName
        chatListView.profileImage = Talk.images[talkItem.userId]
        chatListView.indexChatList = talkList?.filter { $0.userId == talkItem.userId }
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.moveDownChatList()
        }
    }

    func moveDownChatList(){
        topChatListViewContraint?.constant = topBarHeight + topChatListHeight
        view.layoutIfNeeded()
    }

    func ignoreUser(id: Int){
        ignoreLists.append(id)
        tableView.reloadData()
    }
}
