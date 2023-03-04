//
//  ChatNotificationCell.swift
//  wowmate
//
//  Created by 이지웅 on 2023/03/04.
//

import UIKit

class ChatNotificationCell: UITableViewCell {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
      let ChatNotificationTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
          label.font = UIFont.subHead_18R
        label.textColor = UIColor(r: 0, g: 0, b: 0)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let ChatNotificationContext:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
        label.font = UIFont.body_16B
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        label.numberOfLines = 1
        return label
    }()
    
    let ChatNotificationDate:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
        label.font = UIFont.body_16R
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        configure()
//        self.backgroundColor = .white
        self.contentView.addSubview(ChatNotificationTitle)
        self.contentView.addSubview(ChatNotificationContext)
        self.contentView.addSubview(ChatNotificationDate)
        NSLayoutConstraint.activate([
            self.ChatNotificationTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.ChatNotificationTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            self.ChatNotificationContext.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.ChatNotificationContext.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 42),
            self.ChatNotificationDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.ChatNotificationDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 66)
        ])
    }
        
        
        // MARK: - Helpers
        // 설정, 데이터처리 등 액션 외의 메서드를 정의
        func configure(){
//            contentView.layer.borderColor = UIColor.white.cgColor
//            contentView.layer.borderWidth = 2
//            contentView.backgroundColor = .white
//            contentView.layer.cornerRadius = 5
//            contentView.layer.shadowColor = UIColor.black.cgColor
//            contentView.layer.shadowOpacity = 0.25
//            contentView.layer.shadowRadius = 5
//            contentView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
//        override func layoutSubviews() {
//            super.layoutSubviews()
//            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
//        }
        
        
        
    }
