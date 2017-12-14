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
    var ignoreTalkList: [Talk] = []

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
    var leftChatListViewContraint: NSLayoutConstraint?

    var topProfileConstraint: NSLayoutConstraint?
    var leftProfileConstraint: NSLayoutConstraint?

    lazy var profileAnimationView: UIImageView = {
        let imageView = UIImageView()
//        imageView.alpha = 0
        imageView.image = Talk.images[0]
        return imageView
    }()

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

        view.addSubview(profileAnimationView)

        profileAnimationView.autoSetDimensions(to: CGSize(width: imageViewSize, height: imageViewSize))
        leftProfileConstraint = profileAnimationView.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
        topProfileConstraint = profileAnimationView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)

        self.view.addSubview(chatListView)

        chatListView.autoPinEdge(.bottom, to: .top, of: tableView, withOffset: 48)
        leftChatListViewContraint = chatListView.autoPinEdge(toSuperviewEdge: .left, withInset: UIScreen.main.bounds.width)
        chatListView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        chatListView.autoPinEdge(toSuperviewEdge: .top, withInset: topBarHeight)
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

    func sendPush() {

        let parameters = ["to": "R990c1b1631bfe225de6524092cbabaaf",
                                       "messages" :["type":"text","text":"Zaharang Great!!"]] as? [String:AnyObject]

        let url = URL(string: "https://api.line.me/v2/bot/message/push")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer {PexDk0ydhrSYAx/iI310o38PxThlsb7sJSj3Q5zD1+88l4ZEF5OuYwzhjanR9RObsRXE37P5g9js9rjo0/mb7RHmGgus4DnTQBTe89a9/Y5nn/17Y8rejd6VmUqVFxuCJhenP8REC0eUD+HBbtEdbAdB04t89/1O/w1cDnyilFU=}", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
                print (request.httpBody)
        } catch let error {
            print(error.localizedDescription)
        }


        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }


    func fetchData() {
        talkList = TalkDataHelper.shared.getTalkList()
        tableView.reloadData()
        scrollToBottom()
    }

    func closeTopView() {
        UIView.animate(withDuration: 0.23, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.topChatListViewContraint?.constant = topBarHeight
            strongSelf.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.leftChatListViewContraint?.constant = UIScreen.main.bounds.width
            self?.view.layoutIfNeeded()
        })
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

    
    private func scrollToBottom() {
        let indexPath = IndexPath(row: (talkList?.count ?? 0) - 1 , section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }

    func addTalk(_ info: [AnyHashable : Any]) {
        for (key, value) in info {
            guard let keyString: String = key as? String else {
                return
            }

            if keyString == "aps" {
                guard let valDic = value as? [AnyHashable: Any] else {
                    return
                }

                for (vKey, vValue) in valDic {
                    guard let vKeyString = vKey as? String else {
                        return
                    }

                    if vKeyString == "alert" {
                        guard let vValueString = vValue as? String else {
                            return
                        }

                        let splitStrArray = vValueString.split(separator: ":")
                        let idNum: Int = Int(splitStrArray[0])!
                        let msgString = String(splitStrArray[1])
                        if let userName = findUserName(userId: idNum) {
                            let newMessage = Talk(messageId: 300, userId: idNum, userName: userName,
                                                  content: msgString, receivedTime: Date())

                            talkList?.append(newMessage)
                            tableView.reloadData()
                            scrollToBottom()
                        }
                    }
                }
            }
            print("\(key), \(value)")
        }
    }

    func findUserName(userId: Int) -> String? {
        for (key, value) in TalkDataHelper.shared.dumpUsers {
            if key == userId {
                return value
            }
        }

        return nil
    }

    func startSlideAnimation(index: Int){
        if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? GroupChatListCell {
            let offsetY = cell.frame.origin.y + cell.profileImageView.frame.origin.y - tableView.contentOffset.y + topBarHeight

            topProfileConstraint?.constant = offsetY
            leftProfileConstraint?.constant = 10

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
                    self?.leftProfileConstraint?.constant = UIScreen.main.bounds.width
                    self?.view.layoutIfNeeded()
                    }, completion: {[weak self] _ in
                        self?.throwInAnimation()
                })
            })

        }
    }
}

extension GroupChatListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text else { return false }
        
        // secret
        var isSecret: Bool
        let sendText: String
        if text.contains("#") {
            isSecret = true
            sendText = text.components(separatedBy: " ")[1]
            
            // user data, but not use. in this case use static tester info
            // text.components(separatedBy: " ")[0]
        }
        else {
            isSecret = false
            sendText = text
        }
        
        let newMessage = Talk(messageId: 300, userId: meUser.0, userName: meUser.1, content: sendText, receivedTime: Date(), isSecret: isSecret)

        talkList?.append(newMessage)
        tableView.reloadData()
        scrollToBottom()
        
        textField.text = ""


        sendPush()

        return true

    }
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
    
        /////////////////////////////////////////////////////////////////
        // for debugging
//        let randomNo: UInt32 = arc4random_uniform(2);
//        if randomNo == 1 {
//            isBaloonMe = true
//        } else {
//            isBaloonMe = false
//        }
        /////////////////////////////////////////////////////////////////


        guard let talkItem = talkList?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell: GroupChatListCell
        if talkItem.userId == 0 {
            print("talkItem.isSecret: \(talkItem.isSecret)")
            if talkItem.isSecret {
                cell = GroupChatListCellMeSecret(style: .default, reuseIdentifier: "GroupChatListCell")
            }
            else {
                cell = GroupChatListCellMe(style: .default, reuseIdentifier: "GroupChatListCell")
            }
        } else {
            if talkItem.isSecret {
                cell = GroupChatListCellOtherSecret(style: .default, reuseIdentifier: "GroupChatListCell")
            }
            else {
                cell = GroupChatListCellOther(style: .default, reuseIdentifier: "GroupChatListCell")
            }
        }
        
        cell.setupLayoutConstraint(withTalkItem: talkItem)

        cell.profileImageView.image = ignoreLists.contains(talkItem.userId) ? nil : Talk.images[talkItem.userId]
        cell.secretUserProfileImageView.image = #imageLiteral(resourceName: "profile8")
        cell.receivedTimeLabel.text = talkItem.getReceivedTimeString()
        cell.profileNameLabel.text = talkItem.userName
        cell.talkLabel.text = talkItem.content

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

        profileAnimationView.image = Talk.images[talkItem.userId]
        startSlideAnimation(index: index)
    }

    func throwInAnimation(){
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            self?.moveLeftChatList()
        }) { [weak self] _ in
           self?.moveDownList()
        }
    }

    func moveDownList() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.topChatListViewContraint?.constant = strongSelf.topChatListHeight
            strongSelf.view.layoutIfNeeded()
        }, completion: nil)
    }

    func moveLeftChatList(){
        leftChatListViewContraint?.constant = 0
        view.layoutIfNeeded()
    }

    func ignoreUser(id: Int){
        guard let talkList = talkList else { return }
        ignoreLists.append(id)
        tableView.reloadData()
    }
}
