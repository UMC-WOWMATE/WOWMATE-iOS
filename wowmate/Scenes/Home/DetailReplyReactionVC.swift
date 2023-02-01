//
//  DetailReplyReactionVC.swift
//  HomeVC_EX
//
//  Created by Dongwan Ryoo on 2023/01/23.
//

import Foundation
import UIKit

class DetailReplyReactionVC:UIStackView{
    let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "off 2"), for: .normal)
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic 2"), for: .normal)
        return button
    }()
    
    let heartButtonCount:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.numberOfLines = 1
        return label
    }()
    
    let likeButtonCount:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.spacing = 1
        self.axis = .horizontal
        self.alignment = .trailing
        self.addArrangedSubview(heartButton)
        self.addArrangedSubview(likeButton)
        
        [self.heartButton, self.likeButton].forEach{button in button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                
                button.widthAnchor.constraint(equalToConstant: 24),
                button.topAnchor.constraint(equalTo: self.topAnchor),
                button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
            
        }
        
        
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
