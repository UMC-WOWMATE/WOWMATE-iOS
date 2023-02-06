//
//  ChatHeader.swift
//  wowmate
//
//  Created by 장윤정 on 2023/01/25.
//

import UIKit

class ChatHeader: UIView {

    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
//    var imageUrl: String = ""
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        
//        let url = URL(string: imageUrl)
//        imageView.load(url: url!)
        
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        
        imageView.backgroundColor = UIColor.WM.gray300
        imageView.contentMode = .scaleToFill
        imageView.setDimensions(height: 48, width: 48)
        imageView.layer.cornerRadius = (48 / 2)
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.WM.gray300.cgColor
        
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "매칭 제목"
        label.font = .subHead_18B
        label.textColor = UIColor.WM.black
        
        return label
    }()
    
    var cateLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.font = .body_11L
        label.textColor = UIColor.WM.gray500
        
        return label
    }()
    
    lazy var vStackView1: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.cateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 9
        
        stackView.setDimensions(height: 41, width: 180)
        
        return stackView
    }()
    
    var chatMadeDateLabel: UILabel = {
        let label = UILabel()
        label.text = "채팅 생성일 20NN.NN.NN"
        label.font = .body_11L
        label.textColor = UIColor.WM.gray500
        
        return label
    }()

    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    
    // 화면 배치 함수
    func configureUI() {
        
        addSubview(profileImage)
        addSubview(vStackView1)
        addSubview(chatMadeDateLabel)
        
        
        profileImage.anchor(left: leftAnchor, paddingLeft: 16)
        profileImage.centerY(inView: self)
        
        vStackView1.anchor(left: profileImage.rightAnchor, paddingLeft: 16)
        vStackView1.centerY(inView: self)
        
        chatMadeDateLabel.anchor(top: self.topAnchor, right: self.rightAnchor, paddingTop: 16, paddingRight: 16)

        
    }

}
