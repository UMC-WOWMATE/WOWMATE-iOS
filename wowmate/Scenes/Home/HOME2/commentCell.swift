//
//  commentCell.swift
//  wowmate
//
//  Created by Dongwan Ryoo on 2023/03/06.
//

import UIKit

class commentCell:UITableViewCell {
    // MARK: - Properties
    
    let firstrow = UIStackView()
    let secondrow = UIStackView()
    let thirdrow = UIStackView()

    
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    }

