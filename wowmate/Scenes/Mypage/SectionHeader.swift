//
//  FirstSectionHeader.swift
//  wowmate
//
//  Created by 장윤정 on 2023/01/19.
//

import UIKit

class SectionHeader: UIView {

    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "섹션 라벨"
        label.font = .systemFont(ofSize: 14)
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

    // MARK: - Helpers
    
    func configureUI() {
        addSubview(titleLabel)

        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingLeft: 24)
        titleLabel.centerY(inView: self)
        titleLabel.textColor = .systemGray
    }
}
