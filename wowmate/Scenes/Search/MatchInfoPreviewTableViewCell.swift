//
//  MatchInfoPreviewTableViewCell.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/20.
//

import UIKit

class MatchInfoPreviewTableViewCell: UITableViewCell {

    var postInfo: Post? = nil
    
    @IBOutlet weak var matchImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.layer.borderWidth = 1.0
            contentView.layer.borderColor = UIColor(named: "Main00")?.cgColor
        } else {
            contentView.layer.borderWidth = 0.2
            contentView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        let cellInset = 10.0
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: cellInset, left: cellInset, bottom: 0, right: cellInset))
    }
    
    func configure(postInfo: Post) {
        title.text = postInfo.postTitle
        category.text = postInfo.categoryName
        tags.text = postInfo.tag1
        createdDate.text = postInfo.createdDate
        likeCount.text = String(postInfo.postLikeNumber)
    }
    
    func setUpLayout() {
        contentView.layer.borderWidth = 0.2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 10
    }
}
