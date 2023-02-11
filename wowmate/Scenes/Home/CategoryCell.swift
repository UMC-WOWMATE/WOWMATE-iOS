//
//  CategoryCell.swift
//  wowmate
//
//  Created by Dongwan Ryoo on 2023/02/11.
//

import UIKit
import AloeStackView

class CategoryCell:UITableViewCell {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    let CategoryButton = DefaultCategoryButton()
    let CategoryButton1 = DefaultCategoryButton1()
    let CategoryButton2 = DefaultCategoryButton2()
    let CategoryButton3 = DefaultCategoryButton3()
    let CategoryButton4 = DefaultCategoryButton4()
    let CategoryButton5 = DefaultCategoryButton5()
    
    
    let MainCellAddButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(imageLiteralResourceName: "ic"), for: .normal)
        return button
    }()
    
    let CategoryRow: AloeStackView = {
        let stackview = AloeStackView()
        stackview.axis = .horizontal
        stackview.backgroundColor = .white
        stackview.hidesSeparatorsByDefault = true
        return stackview
    }()
    
    let CategoryRow2: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 15
        stackview.alignment  = .center
        stackview.distribution = .equalSpacing
        stackview.backgroundColor = .white
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    
    let categoryBox: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let ImageToggle:UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        return image
    }()
    
    
    
    
    let tableview = HomeVC()

    // MARK: - Lifecycle
        // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    @objc func buttonDidTap() {
        if(CategoryButton.backgroundColor == .white){
            CategoryButton.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        }
        else {
            CategoryButton.backgroundColor = .white
        }
    }
    
    @objc func buttonDidTap1() {
        if(CategoryButton1.backgroundColor == .white){
            CategoryButton1.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        }
        else {
            CategoryButton1.backgroundColor = .white
        }
    }
    @objc func buttonDidTap2() {
        if(CategoryButton2.backgroundColor == .white){
            CategoryButton2.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        }
        else {
            CategoryButton2.backgroundColor = .white
        }
    }
    
    @objc func buttonDidTap3() {
        if(CategoryButton3.backgroundColor == .white){
            CategoryButton3.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        }
        else {
            CategoryButton3.backgroundColor = .white
        }
    }
    
    @objc func buttonDidTap4() {
        if(CategoryButton4.backgroundColor == .white){
            CategoryButton4.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        }
        else {
            CategoryButton4.backgroundColor = .white
        }
    }
    
    @objc func buttonDidTap5() {
        if(CategoryButton5.backgroundColor == .white){
            CategoryButton5.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        }
        else {
            CategoryButton5.backgroundColor = .white
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(categoryBox)
        self.categoryBox.addArrangedSubview(CategoryRow)
        CategoryRow.addRow(CategoryButton)
        CategoryRow.addRow(CategoryButton1)
        CategoryRow.addRow(CategoryButton2)
        CategoryRow.addRow(CategoryButton3)
        CategoryRow.addRow(CategoryButton4)
        CategoryRow.addRow(CategoryButton5)
        self.CategoryButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        self.CategoryButton1.addTarget(self, action: #selector(buttonDidTap1), for: .touchUpInside)
        self.CategoryButton2.addTarget(self, action: #selector(buttonDidTap2), for: .touchUpInside)
        self.CategoryButton3.addTarget(self, action: #selector(buttonDidTap3), for: .touchUpInside)
        self.CategoryButton4.addTarget(self, action: #selector(buttonDidTap4), for: .touchUpInside)
        self.CategoryButton5.addTarget(self, action: #selector(buttonDidTap5), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.categoryBox.heightAnchor.constraint(equalToConstant:50),
            self.categoryBox.widthAnchor.constraint(equalToConstant: 380),
            
            self.CategoryRow.heightAnchor.constraint(equalToConstant: 32),
            self.CategoryRow.widthAnchor.constraint(equalToConstant: 357),
            
            self.CategoryButton.heightAnchor.constraint(equalToConstant: 32),
            self.CategoryButton.widthAnchor.constraint(equalToConstant: 96),
            self.CategoryButton.topAnchor.constraint(equalTo: self.CategoryRow.topAnchor),
            
            self.CategoryButton1.heightAnchor.constraint(equalToConstant: 32),
            self.CategoryButton1.widthAnchor.constraint(equalToConstant: 96),
            self.CategoryButton1.topAnchor.constraint(equalTo: self.CategoryRow.topAnchor),
            
            self.CategoryButton2.heightAnchor.constraint(equalToConstant: 32),
            self.CategoryButton2.widthAnchor.constraint(equalToConstant: 96),
            self.CategoryButton2.topAnchor.constraint(equalTo: self.CategoryRow.topAnchor),
            
            self.CategoryButton3.heightAnchor.constraint(equalToConstant: 32),
            self.CategoryButton3.widthAnchor.constraint(equalToConstant: 96),
            self.CategoryButton3.topAnchor.constraint(equalTo: self.CategoryRow.topAnchor),
            
            self.CategoryButton4.heightAnchor.constraint(equalToConstant: 32),
            self.CategoryButton4.widthAnchor.constraint(equalToConstant: 96),
            self.CategoryButton4.topAnchor.constraint(equalTo: self.CategoryRow.topAnchor),
            
            self.CategoryButton5.heightAnchor.constraint(equalToConstant: 32),
            self.CategoryButton5.widthAnchor.constraint(equalToConstant: 96),
            self.CategoryButton5.topAnchor.constraint(equalTo: self.CategoryRow.topAnchor)
            
            
//            self.CategoryButton2.heightAnchor.constraint(equalToConstant: 32),
//            self.CategoryButton2.widthAnchor.constraint(equalToConstant: 96),
//            self.CategoryButton3.heightAnchor.constraint(equalToConstant: 32),
//            self.CategoryButton3.widthAnchor.constraint(equalToConstant: 96),
//            self.CategoryButton4.heightAnchor.constraint(equalToConstant: 32),
//            self.CategoryButton4.widthAnchor.constraint(equalToConstant: 96),
//            self.CategoryButton5.heightAnchor.constraint(equalToConstant: 32),
//            self.CategoryButton5.widthAnchor.constraint(equalToConstant: 96),
//            self.CategoryButton6.heightAnchor.constraint(equalToConstant: 32),
//            self.CategoryButton6.widthAnchor.constraint(equalToConstant: 96),
//            self.MainCellAddButton.heightAnchor.constraint(equalToConstant: 32),
//            self.MainCellAddButton.widthAnchor.constraint(equalToConstant: 25),
//            self.ImageToggle.heightAnchor.constraint(equalToConstant: 32),
//            self.ImageToggle.widthAnchor.constraint(equalToConstant: 25),
               ])
        
        
//        configure()
//        self.backgroundColor = .white
//        self.contentView.addSubview(MainCellImage)
//        self.contentView.addSubview(MainCellName)
//        self.contentView.addSubview(MainCellCategory)
//        self.contentView.addSubview(MainCellTag)
//        self.contentView.addSubview(MainCellDate)
//        self.contentView.addSubview(MainCellAddButton)
//        self.contentView.addSubview(MainCellLikeButton)
//        self.contentView.addSubview(MainCellLikeCount)
//
//        NSLayoutConstraint.activate([
//            self.MainCellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            self.MainCellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
//            self.MainCellImage.heightAnchor.constraint(equalToConstant: 80),
//            self.MainCellImage.widthAnchor.constraint(equalToConstant: 80),
//            self.MainCellName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 133),
//            self.MainCellName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
//            self.MainCellCategory.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 133),
//            self.MainCellCategory.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
//            self.MainCellTag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 133),
//            self.MainCellTag.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
//            self.MainCellDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 133),
//            self.MainCellDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 97),
//            self.MainCellLikeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 212),
//            self.MainCellLikeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 98),
//            self.MainCellLikeButton.heightAnchor.constraint(equalToConstant: 11),
//            self.MainCellLikeButton.widthAnchor.constraint(equalToConstant: 11),
//            self.MainCellLikeCount.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 96),
//            self.MainCellLikeCount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 225),
//            self.MainCellAddButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 323),
//            self.MainCellAddButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
//            self.MainCellAddButton.heightAnchor.constraint(equalToConstant: 20),
//            self.MainCellAddButton.widthAnchor.constraint(equalToConstant: 20),
//
//        ])
        

    }

    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    func configure(){
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 2
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.25
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
 
