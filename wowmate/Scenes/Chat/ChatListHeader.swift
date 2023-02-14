//
//  ChatListHeader.swift
//  wowmate
//
//  Created by 장윤정 on 2023/01/22.
//

import UIKit

class ChatListHeader: UIView {

    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "채팅"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    let bellImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "bell")
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        
        // 이미지 색 바꾸기
        //imageView.tintColor = UIColor.init(red: 101, green: 81, blue: 224, alpha: 1)
        imageView.tintColor = .black
        
        imageView.contentMode = .scaleToFill
        imageView.setDimensions(height: 19.5, width: 19.5)
        
        return imageView
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
        self.backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(bellImage)

        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 24, paddingLeft: 24)
        bellImage.anchor(bottom: bottomAnchor,right: rightAnchor, paddingBottom: 19.25, paddingRight: 12.25 )

    }
}

