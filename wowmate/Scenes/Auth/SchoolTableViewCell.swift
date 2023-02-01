//
//  SchoolTableViewCell.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/22.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {

    
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        if selected { schoolName.backgroundColor = UIColor(named: "Main02") }
//        else { schoolName.backgroundColor = .clear }
        if selected { accessoryType = .checkmark }
        else { accessoryType = .none }
    }

}
