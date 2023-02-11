//
//  MainCell.swift
//  HomeVC_EX
//
//  Created by Dongwan Ryoo on 2023/01/15.
//

import UIKit
import Moya

class MainCell:UITableViewCell {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    let MainCellImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        //        image.image = UIImage(imageLiteralResourceName: "홍대교표_블루")
        image.layer.cornerRadius = 50
        image.layer.cornerCurve = .continuous
        return image
    }()
    
    @objc func mainCellAddButton(_ sender:Any){
        let alertAction = UIAlertController(title: "게시글 관련 액션을 취해주세요.", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alertAction.addAction(UIAlertAction(title: "삭제", style: .default))
        alertAction.addAction(UIAlertAction(title: "차단", style: .default))
        alertAction.addAction(UIAlertAction(title: "신고", style: .default))
        
        //        present(alertAction, animated: true)
    }
    
    let MainCellAddButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //        button.setImage(UIImage(imageLiteralResourceName: "AddButton"), for: .normal)
        button.addTarget(MainCell.self, action:  #selector(mainCellAddButton), for:.allTouchEvents)
        return button
    }()
    
    
    let MainCellName:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let MainCellCategory:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
        label.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    
    let MainCellTag:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 1
        //        label.text = "#태그"
        return label
    }()
    
    let MainCellDate:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .gray
        label.numberOfLines = 1
        //        label.text = "20NN.00.00"
        return label
    }()
    
    let MainCellLikeButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)
        return button
    }()
    
    let MainCellLikeCount:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .gray
        label.numberOfLines = 1
        //        label.text = "12"
        return label
    }()
    
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        configure()
        self.backgroundColor = .white
        self.contentView.addSubview(MainCellImage)
        self.contentView.addSubview(MainCellName)
        self.contentView.addSubview(MainCellCategory)
        self.contentView.addSubview(MainCellTag)
        self.contentView.addSubview(MainCellDate)
        self.contentView.addSubview(MainCellAddButton)
        self.contentView.addSubview(MainCellLikeButton)
        self.contentView.addSubview(MainCellLikeCount)
        
        NSLayoutConstraint.activate([
            self.MainCellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            self.MainCellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            self.MainCellImage.heightAnchor.constraint(equalToConstant: 80),
            self.MainCellImage.widthAnchor.constraint(equalToConstant: 80),
            self.MainCellName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 133),
            self.MainCellName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            self.MainCellCategory.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 133),
            self.MainCellCategory.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            self.MainCellTag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 133),
            self.MainCellTag.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            self.MainCellDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 133),
            self.MainCellDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 97),
            self.MainCellLikeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 212),
            self.MainCellLikeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 98),
            self.MainCellLikeButton.heightAnchor.constraint(equalToConstant: 11),
            self.MainCellLikeButton.widthAnchor.constraint(equalToConstant: 11),
            self.MainCellLikeCount.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 96),
            self.MainCellLikeCount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 225),
            self.MainCellAddButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 323),
            self.MainCellAddButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            self.MainCellAddButton.heightAnchor.constraint(equalToConstant: 20),
            self.MainCellAddButton.widthAnchor.constraint(equalToConstant: 20),
            
        ])
    }
        
        
        // MARK: - Helpers
        // 설정, 데이터처리 등 액션 외의 메서드를 정의
        func configure(){
            contentView.layer.borderColor = UIColor.white.cgColor
            contentView.layer.borderWidth = 2
            contentView.backgroundColor = .white
            contentView.layer.cornerRadius = 5
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.shadowOpacity = 0.25
            contentView.layer.shadowRadius = 5
            contentView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        }
        
        
        
    }
