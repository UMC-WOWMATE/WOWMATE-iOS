//
//  BubbleCell.swift
//  wowmate
//
//  Created by 장윤정 on 2023/01/25.
//

import UIKit

class BubbleCell: UITableViewCell {

    // MARK: - ProPerties

//    ---------[for sizing]---------
    lazy var labelMaxWidth:CGFloat = (self.frame.width * 0.8)
    
//    ---------[for bubble type]---------
    var bubbleType:String = "날짜+본인"
    
//    ---------[UI components]---------
    lazy var dateLabel:UILabel = {
        let label = UILabel()
        
        label.text = "2023년 01월 01일 땡요일"
        label.font = .body_14R
        label.textColor = UIColor.WM.gray700
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var opponentMessage:UILabel = messageLabel(UIColor.WM.black, UIColor.WM.gray100, labelMaxWidth)
    lazy var myMessage:UILabel = messageLabel(UIColor.WM.white, UIColor.WM.main500, labelMaxWidth)

    var opponentTimeLabel:UILabel = {
        let label = UILabel()
        
        label.text = "00:00"
        label.font = .body_11L
        label.textColor = UIColor.WM.gray600
        
        return label
    }()

    var opponentReadLabel:UILabel = {
        let label = UILabel()
        
        label.text = "1"
        label.font = .body_11L
        label.textColor = UIColor.WM.main500
        
        return label
    }()
    
    lazy var opponentExtraStackView:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [opponentReadLabel, opponentTimeLabel])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 0

        return stackView
    }()
    
    var myTimeLabel:UILabel = {
        let label = UILabel()
        
        label.text = "00:00"
        label.font = .body_11L
        label.textColor = UIColor.WM.gray600
        
        return label
    }()

    var myReadLabel:UILabel = {
        let label = UILabel()
        
        label.text = "1"
        label.font = .body_11L
        label.textColor = UIColor.WM.main500
        
        return label
    }()
    
    lazy var myExtraStackView:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [myReadLabel, myTimeLabel])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fillProportionally
        stackView.spacing = 0

        return stackView
    }()
    
    lazy var opponentView:UIView = {
        let view = UIView()
        
        view.addSubview(opponentMessage)
        view.addSubview(opponentExtraStackView)
        opponentMessage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor)
        opponentExtraStackView.anchor(left: opponentMessage.rightAnchor, bottom: view.bottomAnchor, paddingLeft: 5, paddingBottom: 3)
        opponentExtraStackView.alignment = .leading
        
        return view
    }()
    
    lazy var myView:UIView = {
        let view = UIView()
        
        view.addSubview(myMessage)
        view.addSubview(myExtraStackView)
        myMessage.anchor(top: view.topAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        myExtraStackView.anchor(bottom: view.bottomAnchor ,right: myMessage.leftAnchor, paddingBottom: 3, paddingRight: 5)
        myExtraStackView.alignment = .trailing
        
        return view
    }()
    
    lazy var vStackView:UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 16

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
        addSubview(vStackView)

        vStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
    }
    
    // 날짜 + 상대방 메세지
    func dateOtherConfigureUI() {
        vStackView.addArrangedSubview(dateLabel)
        vStackView.addArrangedSubview(opponentView)
    }
    
    // 상대방 메세지
    func otherConfigureUI() {
        vStackView.addArrangedSubview(opponentView)
    }
    
    // 날짜 + 내 메세지
    func dateMyConfigureUI() {
        vStackView.addArrangedSubview(dateLabel)
        vStackView.addArrangedSubview(myView)
    }
    
    // 내 메세지
    func myConfigureUI() {
        vStackView.addArrangedSubview(myView)
        
    }
    
    // setting type of bubble
    func setBubble(_ type:String){
        bubbleType = type
    }

    
}
