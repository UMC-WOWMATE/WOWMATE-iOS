//
//  listCell.swift
//  wowmate
//
//  Created by Dongwan Ryoo on 2023/02/13.
//


import UIKit

class listCell: UICollectionViewCell {
    
    var memberNameLabel: UILabel!
     
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
        setUpLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
        setUpLabel()
    }
        
    func setUpCell() {
        memberNameLabel = UILabel()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.addSubview(memberNameLabel)
        memberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        memberNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        memberNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        memberNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        memberNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
        
    func setUpLabel() {
        memberNameLabel.font = .body_14B
        memberNameLabel.textAlignment = .center
        memberNameLabel.textColor = .white
        memberNameLabel.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        memberNameLabel.layer.cornerRadius = 100
    }
    
}
