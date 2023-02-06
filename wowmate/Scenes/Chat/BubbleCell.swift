//
//  BubbleCell.swift
//  wowmate
//
//  Created by 장윤정 on 2023/01/25.
//

import UIKit

class BubbleCell: UITableViewCell {

    // MARK: - ProPerties
    
    var maxWidth:CGFloat = 0
    
    lazy var dateLabel:UILabel = {
        let label = UILabel()
        
        label.text = "2023년 01월 28일 토요일"
        label.font = .body_14R
        label.textColor = UIColor.WM.gray700
        label.textAlignment = .center
//        label.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .blue
        
        return label
    }()
    
    lazy var otherMessage:paddingLabel = {
        let label = paddingLabel()
        
        label.text = "안녕하세요! 반가워요ㅎㅎ"
        label.textColor = UIColor.WM.black
        label.font = .body_16R
        label.numberOfLines = 0
//        label.widthAnchor.constraint(equalToConstant: (self.frame.width - 50)).isActive = true
        label.backgroundColor = UIColor.WM.gray100
        // 라벨 둥글게 하기
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        
        
        return label
    }()
    
    lazy var view:UIView = {
        let view = UIView()
        
        view.addSubview(otherMessage)
        otherMessage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor)
        
        return view
    }()
    
//    lazy var vStackView:UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [dateLabel, view])
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.alignment = .leading
//        stackView.distribution = .fillProportionally
//        stackView.spacing = 16
//        stackView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
//        stackView.backgroundColor = .orange
//
//        return stackView
//    }()
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Helpers
    
    func configureUI() {
//        addSubview(vStackView)
//
//        vStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        addSubview(dateLabel)
        addSubview(view)
        
        dateLabel.anchor(top: topAnchor, paddingTop: 16)
        dateLabel.centerX(inView: self)
        
        view.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 12, paddingRight: 12)
        
    }

}
