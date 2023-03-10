//
//  replyTableCell.swift
//  wowmate
//
//  Created by Dongwan Ryoo on 2023/03/06.
//

import UIKit
import Moya

class replyCell:UITableViewCell {
    // MARK: - Properties
    
    let firstrow: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        return stackview
    }()
    
    let secondrow: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        return stackview
    }()
    
    let thirdrow: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        return stackview
    }()
    
    let container: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        return stackview
    }()
    
    let containerLast: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        return stackview
    }()
    
    //autolayout
    func configure(){
        commentreply.snp.makeConstraints { make in
        make.size.width.equalTo(14)
        make.size.height.equalTo(14)
        }
        
        commentlike.snp.makeConstraints { make in
        make.size.width.equalTo(14)
        make.size.height.equalTo(14)
        }


        
    }
    
    
    //firstrow
    let commentsWriter:UILabel = {
        let lb = UILabel()
        lb.font = .body_14R
        lb.text = "익명 1"
        lb.textColor = UIColor.WM.gray700
        
        return lb
    }()
    
    let firstbt:UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(imageLiteralResourceName: "ic"), for: .normal)
        
        return bt
    }()
    
    //secondrow
    let comment:UILabel = {
        let lb = UILabel()
        lb.text = "댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다."
        lb.font = .body_14R
        lb.textColor = UIColor.WM.gray700
        lb.numberOfLines = 0
        return lb
    }()
    
    let commentreply:UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)
        
        return bt
        
    }()
    
    let commentlike:UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(imageLiteralResourceName: "chat"), for: .normal)
        return bt
    }()
    
    let commentlikecount:UILabel = {
        let lb = UILabel()
        lb.text = "sample"
        lb.font = .body_14R
        lb.textColor = UIColor.WM.gray700
        
        return lb
    }()
    
    let comentreplaycount:UILabel = {
        let lb = UILabel()
        lb.text = "sample"
        lb.font = .body_14R
        lb.textColor = UIColor.WM.gray700
        return lb
    }()
    
    let datetext:UILabel = {
        let lb = UILabel()
        lb.text = "2023-12-20"
        lb.font = .body_11L
        lb.textColor = UIColor.WM.gray500
        lb.numberOfLines = 1
        return lb
    }()
    
    
    
    
   
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        
        configure()
        
        //firstrow
        self.firstrow.addArrangedSubview(commentsWriter)
        self.firstrow.addArrangedSubview(firstbt)
        
        //secondrow
        self.secondrow.addArrangedSubview(comment)
        
        //thirdrow
        self.container.addArrangedSubview(commentreply)
        self.container.addArrangedSubview(comentreplaycount)
        self.container.addArrangedSubview(commentlike)
        self.container.addArrangedSubview(commentlikecount)
        
        self.thirdrow.addArrangedSubview(container)
        self.thirdrow.addArrangedSubview(datetext)
        
        self.containerLast.addArrangedSubview(firstrow)
        self.containerLast.addArrangedSubview(secondrow)
        self.containerLast.addArrangedSubview(thirdrow)
        
        contentView.addSubview(containerLast)
        
        
        
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    }
