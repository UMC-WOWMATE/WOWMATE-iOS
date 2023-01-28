//
//  myPageCell2.swift
//  wowmate
//
//  Created by 장윤정 on 2023/01/20.
//

import UIKit

class myPageCell: UITableViewCell {

    // MARK: - ProPerties
    
    let settingLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let explainLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black //.lightGray
        return label
    }()
    
//    let sideView: UIView = {
//
//        let view = UIView()
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "chevron.right")
//        imageView.tintColor = .black
//
//        view.addSubview(imageView)
//
//        imageView.anchor(top: view.topAnchor, left: view.leftAnchor)
//        imageView.centerY(inView: view)
//        //imageView.centerX(inView: view)
//        imageView.backgroundColor = .orange
//
//        return view
//    }()

   
// 스택뷰로 버전 정보를 묶으려 했으나 배치가 안돼 실패
//    lazy var hStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [self.settingLabel, self.explainLabel])
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .horizontal
//        stackView.alignment = .trailing
//        stackView.distribution = .fill
//        stackView.spacing = 8
//        stackView.setDimensions(height: CGFloat(self.frame.height), width: CGFloat(self.frame.width))
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
        
        addSubview(settingLabel)
        addSubview(explainLabel)
        
        settingLabel.anchor(top: topAnchor, left: leftAnchor, paddingLeft: 25)
        explainLabel.anchor(top: topAnchor, right: self.rightAnchor, paddingRight: 24) // 15
        
        settingLabel.centerY(inView: self)
        explainLabel.centerY(inView: self)
        
    }

}
