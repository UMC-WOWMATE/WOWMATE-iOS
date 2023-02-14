//
//  CategoryButton.swift
//  HomeVC_EX
//
//  Created by Dongwan Ryoo on 2023/01/28.
//

import UIKit

//class SelectedCategoryButton: UIButton {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        tintColor = .white
//        backgroundColor = UIColor(r: 101, g: 81, b: 224)
//        titleLabel?.font = .boldSystemFont(ofSize: 16)
//        setTitle("수업", for: .normal)
//        layer.cornerRadius = 16
//        layer.shadowOpacity = 0.1
//        layer.shadowOffset = CGSize(width: 10, height: 10)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented.")
//    }
//
//}

class DefaultCategoryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tintColor = UIColor(r: 101, g: 81, b: 224)
        backgroundColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        layer.cornerRadius = 16
        setTitle("학업", for: .normal)
        setTitleColor(.black, for: .normal)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    @objc func buttonDidTap() {
        print("buttonDidTap")
//        self.title(for: .normal)
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}

class DefaultCategoryButton1: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tintColor = UIColor(r: 101, g: 81, b: 224)
        backgroundColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 14)
        layer.cornerRadius = 16
        setTitle("대외활동/동아리", for: .normal)
        setTitleColor(.black, for: .normal)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}


class DefaultCategoryButton2: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tintColor = UIColor(r: 101, g: 81, b: 224)
        backgroundColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        layer.cornerRadius = 16
        setTitle("운동", for: .normal)
        setTitleColor(.black, for: .normal)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}

class DefaultCategoryButton3: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tintColor = UIColor(r: 101, g: 81, b: 224)
        backgroundColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        layer.cornerRadius = 16
        setTitle("연애", for: .normal)
        setTitleColor(.black, for: .normal)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}

class DefaultCategoryButton4: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tintColor = UIColor(r: 101, g: 81, b: 224)
        backgroundColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        layer.cornerRadius = 16
        setTitle("취미", for: .normal)
        setTitleColor(.black, for: .normal)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}

class DefaultCategoryButton5: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tintColor = UIColor(r: 101, g: 81, b: 224)
        backgroundColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        layer.cornerRadius = 16
        setTitle("기타", for: .normal)
        setTitleColor(.black, for: .normal)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}
