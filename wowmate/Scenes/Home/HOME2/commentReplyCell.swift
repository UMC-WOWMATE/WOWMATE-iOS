//
//  commentReplyCell.swift
//  wowmate
//
//  Created by Dongwan Ryoo on 2023/03/13.
//
import UIKit
import SnapKit

class commentReplyCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var ID:Int = -1
    
    let container:UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 3
        return stackview
    }()
    
    let userid:UILabel = {
        let label = UILabel()
        label.text = "익명"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let useridcontainer:UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 3
        return stackview
    }()
    
    let usertext:UILabel = {
        let label = UILabel()
        label.text = "댓글내용"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let replystack3:UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.spacing = 3
        stackview.distribution = .fill
        return stackview
    }()
    
    let datetext:UILabel = {
        let label = UILabel()
        label.text = "20NN.NN.NN 00:00"
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textAlignment = .right
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    
    let like:UILabel = {
        let label = UILabel()
//        label.text = "0"
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    let reply:UILabel = {
        let label = UILabel()
//        label.text = "0"
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    let vectorButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)
        return button
        
    }()
    
    func setUp() {
        vectorButton.snp.makeConstraints { make in
            make.height.width.equalTo(15)
        }
    }
    
    let lastStackVeiw:UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        
        
        return stackview
        
    }()
    
    let detailreplyreactionVC = DetailReplyReactionVC()
    
    let replytableview = UITableView(frame: .zero, style: .grouped)
    var replies: [CommentReply] = [] {
         didSet {
             replytableview.reloadData()
         }
     }
    
    func tableviwSetUp(){
        
        
    }
    
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.replytableview.dataSource = self
        self.replytableview.delegate = self
        self.replytableview.register(replycell2.self, forCellReuseIdentifier: "replycell2")
        self.replytableview.separatorStyle = .none
        setUp()
//        self.contentView.layer.borderColor = UIColor(r: 101, g: 81, b: 224).cgColor
//        self.contentView.layer.borderWidth = 1
        self.contentView.layer.cornerRadius = 5
//        self.contentView.addSubview(lastStackVeiw)
//        self.lastStackVeiw.addArrangedSubview(vectorButton)
//        self.lastStackVeiw.addArrangedSubview(container)
        self.contentView.addSubview(container)
        self.container.addArrangedSubview(useridcontainer)
        self.useridcontainer.addArrangedSubview(userid)
        self.container.addArrangedSubview(usertext)
        self.container.addArrangedSubview(replystack3)
        self.replystack3.addArrangedSubview(detailreplyreactionVC)
        self.replystack3.addArrangedSubview(datetext)
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reply = replies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "replycell2", for: indexPath) as! replycell2
        
        cell.usertext.text = reply.commentReplyContext
        cell.like.text = "Likes: \(reply.likeNumber)"
        cell.datetext.text = reply.createdDate
        return cell
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

