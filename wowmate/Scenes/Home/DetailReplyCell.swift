//
//  DetailReplyCell.swift
//  HomeVC_EX
//
//  Created by Dongwan Ryoo on 2023/01/18.
//
import Foundation
import UIKit

class DetailReplyCell: UITableViewCell {
    
     
        
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
        label.text = "0"
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    let reply:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    let detailreplyreactionVC = DetailReplyReactionVC()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
