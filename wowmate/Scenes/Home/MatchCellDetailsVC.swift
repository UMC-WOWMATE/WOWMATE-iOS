//
//  MatchCellDetailsVC.swift
//  HomeVC_EX
//
//  Created by Dongwan Ryoo on 2023/01/22.
//

import Foundation
import UIKit

class MatchCellDetailsVC: UIViewController {
    
    let NavigationTitleView:UILabel = {
        let navigationtitleview = UILabel()
        navigationtitleview.translatesAutoresizingMaskIntoConstraints = false
        navigationtitleview.text = "매칭 제목"
        navigationtitleview.numberOfLines = 1
        navigationtitleview.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        return navigationtitleview
    }()
    
    let DetailImage:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "ic"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     let container: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
         stackView.axis = .horizontal
         stackView.distribution = .fillEqually
        return stackView
    }()
    
    let setdate:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "등록일"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        return label
        
    }()
    
    let setlike:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let setview:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "조회수"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .right
        return label
    }()
    
    let matchingmember:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "모집인원 N명"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let matchingtext:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "소개"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let matchingtextfeild:UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.backgroundColor = .gray
        label.text = "텍스트 입력"
        label.layer.opacity = 0.2
        return label
    }()
    
    let reply:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "댓글"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let replypost:UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.spacing = 3
        stackview.distribution = .fillProportionally
        return stackview
    }()
    
    let replytext:UITextView = {
        let textview = UITextView()
        textview.backgroundColor = .gray
        textview.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textview.layer.opacity = 0.2
        textview.translatesAutoresizingMaskIntoConstraints = false
        return textview
        }()
    
    let replybutton : UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .purple
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("등록", for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 14,weight: .bold)
        bt.layer.cornerRadius = 5
        return bt
        
    }()
    
    let chatpost:UIButton = {
       let button = UIButton()
        button.backgroundColor = .purple
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("채팅 걸기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18,weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    @objc private func backButtonPressed(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
        }

    let tableview = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(NavigationTitleView)
        self.view.addSubview(DetailImage)
        self.view.addSubview(container)
        self.container.addArrangedSubview(setdate)
        self.container.addArrangedSubview(setlike)
        self.container.addArrangedSubview(setview)
        self.view.addSubview(matchingmember)
        self.view.addSubview(matchingtext)
        self.view.addSubview(matchingtextfeild)
        self.view.addSubview(reply)
        self.view.addSubview(tableview)
        self.view.addSubview(chatpost)
        self.view.addSubview(replypost)
        self.replypost.addArrangedSubview(replytext)
        self.replypost.addArrangedSubview(replybutton)
        self.tableview.translatesAutoresizingMaskIntoConstraints = false
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(DetailReplyCell.self, forCellReuseIdentifier: "DetailReplyCell")
        self.tableview.reloadData()
        self.tableview.separatorStyle = .none
        self.tableview.layoutIfNeeded()
        self.tableview.rowHeight = 80
        
        view.backgroundColor = .white
        
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(imageLiteralResourceName:"ic 1"), style: .plain, target:self , action: #selector(backButtonPressed))
        NSLayoutConstraint.activate([
            self.NavigationTitleView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 108),
            self.NavigationTitleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            self.DetailImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.DetailImage.widthAnchor.constraint(equalToConstant: 24),
            self.DetailImage.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 108),
            self.container.widthAnchor.constraint(equalToConstant: 300),
            self.container.heightAnchor.constraint(equalToConstant: 14),
            self.container.topAnchor.constraint(equalTo: self.NavigationTitleView.topAnchor, constant: 44),
            self.container.leadingAnchor.constraint(equalTo: self.NavigationTitleView.leadingAnchor ),
            self.matchingmember.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 60),
            self.matchingmember.leadingAnchor.constraint(equalTo: self.NavigationTitleView.leadingAnchor),
            self.matchingtext.topAnchor.constraint(equalTo: self.matchingmember.topAnchor, constant: 96),
            self.matchingtext.leadingAnchor.constraint(equalTo: self.NavigationTitleView.leadingAnchor),
            self.matchingtextfeild.leadingAnchor.constraint(equalTo: self.NavigationTitleView.leadingAnchor),
            self.matchingtextfeild.topAnchor.constraint(equalTo: self.matchingtext.topAnchor, constant: 24),
            self.matchingtextfeild.heightAnchor.constraint(equalToConstant: 115),
            self.matchingtextfeild.widthAnchor.constraint(equalToConstant: 361),
            self.tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 602),
            self.tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -90),
            self.tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            self.tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            self.reply.topAnchor.constraint(equalTo: self.tableview.topAnchor,constant:  -24),
            self.reply.leadingAnchor.constraint(equalTo: self.tableview.leadingAnchor),
            self.chatpost.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -10),
            self.chatpost.leadingAnchor.constraint(equalTo: self.tableview.leadingAnchor),
            self.chatpost.widthAnchor.constraint(equalToConstant: 360),
            self.chatpost.heightAnchor.constraint(equalToConstant: 40),
            self.replypost.leadingAnchor.constraint(equalTo: self.tableview.leadingAnchor),
            self.replypost.bottomAnchor.constraint(equalTo: self.chatpost.bottomAnchor, constant: -45),
            self.replytext.widthAnchor.constraint(equalToConstant: 330),
            self.replytext.heightAnchor.constraint(equalTo: self.replybutton.heightAnchor),
            self.replytext.leadingAnchor.constraint(equalTo: self.replypost.leadingAnchor),
            self.replybutton.trailingAnchor.constraint(equalTo: self.replypost.trailingAnchor)
        ])
        
    
        
    }


}

extension MatchCellDetailsVC:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailReplyCell") as! DetailReplyCell
        cell.backgroundColor = .white
        return cell
    }
    
 

    
    
}
