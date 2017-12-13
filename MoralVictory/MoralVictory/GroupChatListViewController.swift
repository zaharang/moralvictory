//
//  GroupChatListViewController.swift
//  MoralVictory
//
//  Created by 김도윤 on 2017. 12. 13..
//  Copyright © 2017년 김도윤. All rights reserved.
//

import UIKit

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
    
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(GroupChatListCell.self, forCellReuseIdentifier: "GroupChatListCell")
        
        tableView.reloadData()
    }
}

extension GroupChatListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GroupChatListCell(style: .default, reuseIdentifier: "GroupChatListCell")
        
        cell.profileImageView.image = UIImage(named: "profile-pictures")
        cell.talkLabel.text = "HelloWorld"
        cell.backgroundColor = UIColor.green
        return cell
    }
}
