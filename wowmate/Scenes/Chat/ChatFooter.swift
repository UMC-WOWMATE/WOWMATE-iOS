//
//  ChatFooter.swift
//  wowmate
//
//  Created by 장윤정 on 2023/01/25.
//

import UIKit

class ChatFooter: UIView {

    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    lazy var messageField:UITextField = {
        let textfield = UITextField()
        
        textfield.text = "  메세지 보내기"
        textfield.textColor = UIColor.WM.gray_700
        textfield.setDimensions(height: 32, width: (self.frame.width - 68))
        textfield.layer.cornerRadius = 10
        textfield.backgroundColor = UIColor.WM.gray_100
        
        return textfield
    }()
    
    let sendButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        
        button.setDimensions(height: 24, width: 24)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = UIColor.WM.main

        
        return button
    }()
    
    lazy var hStackView:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.messageField, self.sendButton])
        
        stackView.setDimensions(height: 32, width: (self.frame.width - 32))
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        
        return stackView
    }()
    

    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        addAction()
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
        addSubview(hStackView)
        
        hStackView.centerY(inView: self)
        hStackView.centerX(inView: self)
        
    }
    
    func addAction() {
        messageField.addTarget(self, action: #selector(messFieldClick), for: .touchUpInside)
    }
    
    @objc func messFieldClick() {
        messageField.becomeFirstResponder()
    }

}
