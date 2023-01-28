//
//  ChatListCell.swift
//  wowmate
//
//  Created by 장윤정 on 2023/01/21.
//

import UIKit

class ChatListCell: UITableViewCell {
    
    // MARK: - ProPerties
    
    let imageUrl: String = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC_Varq6a2k-TR670RYQkEfHPGgRYXArbGuw&usqp=CAU"
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        
        let url = URL(string: imageUrl)
        imageView.load(url: url!)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        
        imageView.contentMode = .scaleToFill
        imageView.setDimensions(height: 56, width: 56)
        imageView.layer.cornerRadius = (56 / 2)
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "매칭 제목"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        
        return label
    }()
    
    var recentChatLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 대화 내용"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        
        return label
    }()
    
    lazy var vStackView1: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.recentChatLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        
        stackView.setDimensions(height: 45, width: 150)
        
        return stackView
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "오후 00:00"
        label.font = .systemFont(ofSize: 11)
        label.textColor = .lightGray
        
        return label
    }()
    
    var newMessageImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "n.circle.fill")
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        
        // 이미지 색 바꾸기
        //imageView.tintColor = UIColor(r: 101, g: 81, b: 244)

        
        imageView.contentMode = .scaleToFill
        imageView.setDimensions(height: 16, width: 16)
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = .systemFont(ofSize: 11)
        
        return label
    }()
    
    lazy var vStackView2: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.timeLabel, self.newMessageImage, self.emptyLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        stackView.setDimensions(height: 54, width: 60)
        
        return stackView
    }()
    
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
        
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(profileImage)
        addSubview(vStackView1)
        addSubview(vStackView2)
        
        
        profileImage.anchor(left: leftAnchor, paddingLeft: 16)
        profileImage.centerY(inView: self)
        
        vStackView1.anchor(left: profileImage.rightAnchor, paddingLeft: 16)
        vStackView1.centerY(inView: self)
        
        vStackView2.anchor(right: self.rightAnchor, paddingRight: 16)
        vStackView2.centerY(inView: self)
        
    }
    
    func lineDraw(viewLi:UIView)
        {
            let border = CALayer()
            let width = CGFloat(1.0)
            border.borderColor = UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1.0).cgColor
            border.frame = CGRect(x: 0, y: viewLi.frame.size.height - width, width:  viewLi.frame.size.width, height: viewLi.frame.size.height)
            border.borderWidth = width
            viewLi.layer.addSublayer(border)
            viewLi.layer.masksToBounds = true
        }
    
}
