//
//  paddingLabel.swift
//  wowmate
//
//  Created by 장윤정 on 2023/02/01.
//

import UIKit

class paddingLabel:UILabel {
    private var padding = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    
    convenience init(padding: UIEdgeInsets) {
            self.init()
            self.padding = padding
    }
    
    override func drawText(in rect: CGRect) {
        let paddingRect = rect.inset(by: padding)
        super.drawText(in: paddingRect)
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}

func messageLabel(_ textColor:UIColor, _ backgroundColor:UIColor, _ labelMaxWidth:CGFloat) -> UILabel {
    let label = paddingLabel()
    
    label.text = "안녕하세요! 반가워요ㅎㅎ 제 이름은 홍길동입니다. 앞으로 잘 지내 봐요~"
    label.textColor = textColor
    label.backgroundColor = backgroundColor
    label.font = .body_16R
    label.numberOfLines = 0
    // 라벨 둥글게 하기
    label.clipsToBounds = true
    label.layer.cornerRadius = 10
    // 라벨 크기 제한
    label.preferredMaxLayoutWidth = labelMaxWidth
    // 라벨 줄바꿈 속성
    label.lineBreakMode = .byCharWrapping
    
    
    return label
}

var messtimeLabel:UILabel = {
    let label = UILabel()
    
    label.text = "00:00"
    label.font = .body_11L
    label.textColor = UIColor.WM.gray600
    
    return label
}()

var readLabel:UILabel = {
    let label = UILabel()
    
    label.text = "1"
    label.font = .body_11L
    label.textColor = UIColor.WM.main500
    
    return label
}()

func extraLabel() -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: [readLabel, messtimeLabel])

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
//    stackView.alignment = .leading
    stackView.distribution = .fillProportionally
    stackView.spacing = 0

    return stackView
}
