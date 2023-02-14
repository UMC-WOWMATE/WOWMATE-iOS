//
//  imageCell.swift
//  wowmate
//
//  Created by Dongwan Ryoo on 2023/02/13.
//


import UIKit

class imageCell: UICollectionViewCell {
    
    var memberImage: UIImageView!
    
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
        memberImage = UIImageView()
        memberImage.contentMode = .scaleAspectFit
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.addSubview(memberImage)
        memberImage.translatesAutoresizingMaskIntoConstraints = false
        memberImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        memberImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        memberImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        memberImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        memberImage.clipsToBounds = true
        
        
    }
    
    func setUpLabel() {
        //        memberImage.image
    }
    
}
