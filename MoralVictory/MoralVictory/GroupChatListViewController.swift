//
//  GroupChatListViewController.swift
//  MoralVictory
//
//  Created by 김도윤 on 2017. 12. 13..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit

let topBarHeight = CGFloat(44)
let imageViewSize = CGFloat(40)

class GroupChatListCell: UITableViewCell {
    var talkLabel = UILabel()
    var profileImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(talkLabel)
        self.contentView.addSubview(profileImageView)
        
        print("\(self.frame)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        profileImageView.frame = CGRect(x: 20, y: (frame.height - imageViewSize)/2, width: imageViewSize, height: imageViewSize)
        let textViewX = profileImageView.frame.origin.x + imageViewSize + 20
        talkLabel.frame = CGRect(x: textViewX, y: 0, width: frame.width - textViewX, height: frame.height)
    }
}

class GroupChatListViewController: UIViewController {
    
    var talkList: [Talk]?
    
    var tableView:UITableView!
    var topBarView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBarView = UIImageView(image: UIImage(named: "navi_bar"))
        topBarView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: topBarHeight)
        self.view.addSubview(topBarView)
        
        let tableViewFrame = CGRect(x: 0, y: topBarHeight, width: view.frame.width, height: view.frame.height - topBarHeight)
        tableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(GroupChatListCell.self, forCellReuseIdentifier: "GroupChatListCell")

        fetchData()

    }

    func fetchData(){
        talkList = TalkDataHelper.shared.getTalkList()
        tableView.reloadData()
    }
}

extension GroupChatListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talkList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GroupChatListCell(style: .default, reuseIdentifier: "GroupChatListCell")

        guard let talkItem = talkList?[indexPath.row] else {
            return cell
        }

        cell.profileImageView.image = UIImage(named: "profile-pictures")
        cell.talkLabel.text = talkItem.userName
        cell.backgroundColor = UIColor.green
        return cell
    }
}
