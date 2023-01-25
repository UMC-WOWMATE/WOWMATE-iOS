//
//  MainCell.swift
//  HomeVC_EX
//
//  Created by Dongwan Ryoo on 2023/01/15.
//

import Foundation
import UIKit
// MARK: - Helpers

final class MainCell:UITableViewCell {
    
    var MainImage:UIImageView = {
        let mainimage = UIImageView()
        mainimage.translatesAutoresizingMaskIntoConstraints = false
        mainimage.image = UIImage(imageLiteralResourceName: "홍대교표_블루")
        mainimage.layer.cornerRadius = 50
        mainimage.layer.cornerCurve = .continuous
        return mainimage

    }()
    
    var addImage:UIImageView = {
        let addimage = UIImageView()
        addimage.translatesAutoresizingMaskIntoConstraints = false
        addimage.image = UIImage(imageLiteralResourceName: "ic")
        return addimage
        
    }()
    
    
    var MatchingName:UILabel = {
        
        let matchingname = UILabel()
        matchingname.translatesAutoresizingMaskIntoConstraints = false
        matchingname.contentMode = .scaleAspectFill
        matchingname.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        matchingname.textColor = .black
        matchingname.numberOfLines = 1
        matchingname.textAlignment = .center
        matchingname.text = "매칭 제목"
        return matchingname
    
    }()
    
    var MatchingCategory:UILabel = {
        
        let matchingcategory = UILabel()
        matchingcategory.translatesAutoresizingMaskIntoConstraints = false
        matchingcategory.contentMode = .scaleAspectFill
        matchingcategory.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        matchingcategory.textColor = .gray
        matchingcategory.numberOfLines = 1
        matchingcategory.text = "카테고리"
        return matchingcategory
    }()
    
    var MatchingTag:UILabel = {
      
        let matchingtag = UILabel()
        matchingtag.translatesAutoresizingMaskIntoConstraints = false
        matchingtag.contentMode = .scaleAspectFill
        matchingtag.font = UIFont.systemFont(ofSize: 14)
        matchingtag.textColor = .gray
        matchingtag.numberOfLines = 1
        matchingtag.text = "#태그"
        return matchingtag
        
    }()
    
    var MatchingDate:UILabel = {
      
        let matchingdate = UILabel()
        matchingdate.translatesAutoresizingMaskIntoConstraints = false
        matchingdate.contentMode = .scaleAspectFill
        matchingdate.font = UIFont.systemFont(ofSize: 11)
        matchingdate.textColor = .black
        matchingdate.numberOfLines = 1
        matchingdate.text = "20NN.00.00"
        return matchingdate
        
    }()
    
    var MatchingLike:UILabel = {
      
        let mkatchinglike = UILabel()
        mkatchinglike.translatesAutoresizingMaskIntoConstraints = false
        mkatchinglike.contentMode = .scaleAspectFill
        mkatchinglike.font = UIFont.systemFont(ofSize: 14)
        mkatchinglike.textColor = .black
        mkatchinglike.numberOfLines = 1
        return mkatchinglike
        
    }()
    
    var MatchingLook:UILabel = {
      
        let matchinglook = UILabel()
        matchinglook.translatesAutoresizingMaskIntoConstraints = false
        matchinglook.contentMode = .scaleAspectFill
        matchinglook.font = UIFont.systemFont(ofSize: 14)
        matchinglook.textColor = .black
        matchinglook.numberOfLines = 1
        return matchinglook
        
    }()
    
    var MatchingDetails:UILabel = {
        
        let matchingdetails = UILabel()
        matchingdetails.translatesAutoresizingMaskIntoConstraints = false
        matchingdetails.contentMode = .scaleAspectFill
        matchingdetails.font = UIFont.systemFont(ofSize: 20)
        matchingdetails.textColor = .black
        matchingdetails.numberOfLines = 1
        return matchingdetails
    
    }()
    
    let MatchingBox:UIStackView = {
        let matchingbox = UIStackView()
        matchingbox.axis = .horizontal
        matchingbox.layer.borderColor = UIColor.systemPurple.cgColor
        matchingbox.spacing = 6
        return matchingbox
        
    }()
    

    
   
    
    
    // MARK: - Helpers
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.layer.borderWidth = 2
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.25
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.contentView.addSubview(MainImage)
        self.contentView.addSubview(MatchingName)
        self.contentView.addSubview(MatchingCategory)
        self.contentView.addSubview(MatchingTag)
        self.contentView.addSubview(MatchingDate)
        self.contentView.addSubview(addImage)
//        self.contentView.addSubview(self.Maincontent)
//        self.MatchingBox.addArrangedSubview(self.MatchingName)
//        self.MatchingBox.addArrangedSubview(self.MatchingCategory)
//        self.MatchingBox.addArrangedSubview(self.MatchingTag)
//        self.MatchingBox.addArrangedSubview(self.MatchingDate)
//        self.MatchingBox.addArrangedSubview(self.MatchingLike)
//        self.MatchingBox.addArrangedSubview(self.MatchingLook)
//        self.MatchingBox.addArrangedSubview(self.MatchingDetails)
          
        NSLayoutConstraint.activate([
            self.MainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            self.MainImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            self.MainImage.heightAnchor.constraint(equalToConstant: 90),
            self.MainImage.widthAnchor.constraint(equalToConstant: 90),
            self.MatchingName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 133),
            self.MatchingName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            self.MatchingCategory.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 133),
            self.MatchingCategory.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            self.MatchingTag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 133),
            self.MatchingTag.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            self.MatchingDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 133),
            self.MatchingDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 107),
            self.addImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 323),
            self.addImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            self.addImage.heightAnchor.constraint(equalToConstant: 20),
            self.addImage.widthAnchor.constraint(equalToConstant: 20)
        ])
        

    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
//      }
//
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
 
