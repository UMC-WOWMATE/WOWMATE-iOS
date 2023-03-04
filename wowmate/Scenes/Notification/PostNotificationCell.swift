//
//  PostNotificationCell.swift
//  wowmate
//
//  Created by 이지웅 on 2023/03/03.
//

import UIKit

class PostNotificationCell: UITableViewCell {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
      let PostNotificationTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
          label.font = UIFont.subHead_18R
        label.textColor = UIColor(r: 0, g: 0, b: 0)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let PostNotificationContext:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
        label.font = UIFont.body_16B
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        label.numberOfLines = 1
        return label
    }()
    
    let PostNotificationDate:UILabel = {
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
        self.contentView.addSubview(PostNotificationTitle)
        self.contentView.addSubview(PostNotificationContext)
        self.contentView.addSubview(PostNotificationDate)
        NSLayoutConstraint.activate([
            self.PostNotificationTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.PostNotificationTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            self.PostNotificationContext.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.PostNotificationContext.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 42),
            self.PostNotificationDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.PostNotificationDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 66)
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
