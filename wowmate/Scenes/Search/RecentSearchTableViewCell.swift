//
//  RecentSearchTableViewCell.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/19.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keywordLabel: UILabel!
    weak var delegate: RecentSearchDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func didTapDeleteButton(_ sender: UIButton) {
        delegate?.deleteSelectedKeyword(self)
    }
}
