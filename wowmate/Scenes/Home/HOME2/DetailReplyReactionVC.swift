//
//  DetailReplyReactionVC.swift
//  HomeVC_EX
//
//  Created by Dongwan Ryoo on 2023/01/23.
//

import Foundation
import UIKit
import AloeStackView

class DetailReplyReactionVC:UIStackView{
    let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "off 2"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic 2"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let heartButtonCount:UILabel = {
        let label = UILabel()
        label.text = "3"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    let likeButtonCount:UILabel = {
        let label = UILabel()
        label.text = "1"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.spacing = 1
        self.axis = .horizontal
        self.alignment = .trailing
        self.addArrangedSubview(heartButton)
        self.addArrangedSubview(heartButtonCount)
        self.addArrangedSubview(likeButton)
        self.addArrangedSubview(likeButtonCount)
        
        [self.heartButton, self.heartButtonCount, self.likeButton,self.likeButtonCount].forEach{button in button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.heartButton.heightAnchor.constraint(equalToConstant: 10),
                self.heartButton.widthAnchor.constraint(equalToConstant: 10),
                self.likeButton.heightAnchor.constraint(equalToConstant: 10),
                self.likeButton.widthAnchor.constraint(equalToConstant: 10),
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
