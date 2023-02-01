//
//  paddingLabel.swift
//  wowmate
//
//  Created by 장윤정 on 2023/02/01.
//

import UIKit

class paddingLabel:UILabel {
    private var padding = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    
    convenience init(padding: UIEdgeInsets) {
            self.init()
            self.padding = padding
    }
    
    override func drawText(in rect: CGRect) {
        let paddingRect = rect.inset(by: padding)
        super.drawText(in: paddingRect)
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}
