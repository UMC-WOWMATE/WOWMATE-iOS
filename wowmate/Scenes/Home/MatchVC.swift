//
//  MatchVC.swift
//  wowmate
//
//  Created by 이지웅 on 2023/02/05.
//

import Foundation
import UIKit
import AloeStackView
import YPImagePicker

class MatchVC: AloeStackViewController {
    // MARK: - Properties
    var titleTextField = UITextField()
    var categoryPickerView = UIPickerView()
    var memberTextField = UITextField()
    var tagStackView = AloeStackView()
    var contextsTextView = UITextView()
    var imageStackView = AloeStackView()
    
    let placeholder = "내용을 입력해주세요. (10 ~ 300자)"
    var List_of_Category: [String] = []
    var Tags: [String] = []
    var Images: [UIImage] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationbarView()
        setUpGetTitle()
        setUpGetCategory()
        setUpGetMember()
        setUpGetTag()
        setUpGetContext()
        setUpGetImage()
    }

    func setUpNavigationbarView() {
        navigationController?.navigationBar.backgroundColor = .white
        
        let closeButton = UIBarButtonItem(image: UIImage(named: "ic_del"), style: .plain, target: self, action: #selector(closeButtonDidTab(_:)))
        closeButton.tintColor = .black
        
        let saveButton = UIBarButtonItem(image: UIImage(named: "btn_save"), style: .plain, target: self, action: #selector(saveButtonDidTab(_:)))
        
        let temsaveButton = UIBarButtonItem(image: UIImage(named: "btn_temsave"), style: .plain, target: self, action: #selector(temsaveButtonDidTab(_:)))
        temsaveButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItems = [saveButton, temsaveButton]
    }
    
    func setUpGetTitle() {
//        titleTextField.textColor = .systemGray
        titleTextField.placeholder = "제목을 입력해주세요. (20자 내외)"
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addRow(titleTextField)
    }
    
    func setUpGetCategory() {
        let categoryLabel = UILabel()
        categoryLabel.textColor = .systemGray
        categoryLabel.text = "카테고리를 선택해주세요.(필수)"
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addRow(categoryLabel)
        stackView.hideSeparator(forRow: categoryLabel)
        
        List_of_Category = ["학업", "대외활동/동아리", "운동", "연애", "취미", "기타"]
        categoryPickerView.delegate = self
        categoryPickerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addRow(categoryPickerView)
        
    }
    
    func setUpGetMember() {
        let memberrow = UIStackView()
        memberrow.axis = .horizontal
        memberrow.alignment = .fill
        memberrow.spacing = 8
        memberrow.translatesAutoresizingMaskIntoConstraints = false
        
        let label1 = UILabel()
        label1.textColor = .systemGray
        label1.text = "모집인원"
        
        memberTextField.textColor = .black
        memberTextField.placeholder = "0"
        memberTextField.textAlignment = .center
        memberTextField.keyboardType = .numberPad
        memberTextField.layer.borderWidth = 0.5
        memberTextField.layer.borderColor = UIColor.black.cgColor
        memberTextField.layer.cornerRadius = 10
        memberTextField.widthAnchor.constraint(equalToConstant: 43).isActive = true
        
        let label2 = UILabel()
        label2.textColor = .systemGray
        label2.text = "명"
        
        let label3 = UILabel()
        label3.textColor = .systemGray
        label3.text = "* 0명일 경우 '무관'으로 표시됩니다"
        label3.textAlignment = .center
        label3.numberOfLines = 2
        
        memberrow.addArrangedSubview(label1)
        memberrow.addArrangedSubview(memberTextField)
        memberrow.addArrangedSubview(label2)
        memberrow.addArrangedSubview(label3)

        stackView.addRow(memberrow)
    }
    
    func setUpGetTag() {
        let tagrow = UIStackView()
        tagrow.axis = .horizontal
        tagrow.alignment = .leading
        
        let addtagButton = UIButton()
        addtagButton.setImage(UIImage(named: "btn_addtag"), for: .normal)
        
        addtagButton.addTarget(self, action: #selector(addTagsButtonDidTab(_:)), for: .touchUpInside)
        
        tagStackView.axis = .horizontal
        tagStackView.hidesSeparatorsByDefault = true
        showTag()
        
        tagrow.addArrangedSubview(addtagButton)
        tagrow.addArrangedSubview(tagStackView)
        
        stackView.addRow(tagrow)
    }
    
    func showTag() {
        
        if Tags.isEmpty {
            let defaultMessage = UILabel()
            defaultMessage.text = "#태그를 #추가해주세요"
            tagStackView.addRow(defaultMessage)
        }
        else {
            tagStackView.removeAllRows()
            for tag in Tags {
                let label = UILabel()
                label.text = "#" + tag
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isUserInteractionEnabled = true
                tagStackView.addRow(label)
        
                tagStackView.setTapHandler(forRow: label) { [weak self] _ in

                    let index = self?.Tags.firstIndex(of: tag)
                    let alert = UIAlertController(
                        title: "\(index!+1)번 태그를 삭제하시겠습니까?",
                        message: nil,
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "삭제", style: .default, handler: { action in
                        self?.Tags.remove(at: index!)
                        self?.tagStackView.removeRow(label)
                    }))

                    self?.present(alert, animated: true)

                }
            }
        }
    }
    
    func setUpGetContext() {
        let contextLabel = UILabel()
        contextLabel.textColor = .black
        contextLabel.text = "소개"
        contextLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addRow(contextLabel)
        stackView.hideSeparator(forRow: contextLabel)
        
        contextsTextView.delegate = self
        contextsTextView.text = placeholder
        contextsTextView.textColor = .gray
        contextsTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        contextsTextView.backgroundColor = .lightGray
        contextsTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        contextsTextView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addRow(contextsTextView)
    }
    
    func setUpGetImage() {
        let imageLabel = UILabel()
        imageLabel.textColor = .black
        imageLabel.text = "이미지"
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addRow(imageLabel)
        stackView.hideSeparator(forRow: imageLabel)
        
        imageStackView.axis = .horizontal
        imageStackView.hidesSeparatorsByDefault = true
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        showImage()
        stackView.addRow(imageStackView)
        
    }
    
    func showImage() {
        let addImageButton = UIButton()
        addImageButton.setImage(UIImage(named: "btn_addpic"), for: .normal)
        addImageButton.widthAnchor.constraint(equalToConstant: 92).isActive = true
        addImageButton.heightAnchor.constraint(equalToConstant: 92).isActive = true
        addImageButton.addTarget(self, action: #selector(addPhotosButtonDidTap(_:)), for: .touchUpInside)
        imageStackView.removeAllRows()
        imageStackView.addRow(addImageButton)
        
        for image in self.Images {
            let imageview = UIImageView()
            imageview.image = image
            imageview.isUserInteractionEnabled = true
            imageview.widthAnchor.constraint(equalToConstant: 92).isActive = true
            imageview.heightAnchor.constraint(equalToConstant: 92).isActive = true
            self.imageStackView.addRow(imageview)
            self.imageStackView.hideSeparator(forRow: imageview)
            
            //삭제
            imageStackView.setTapHandler(forRow: imageview) { [weak self] _ in
                
                let index = self?.Images.firstIndex(of: image)
                let alert = UIAlertController(
                    title: "\(index!+1)번 이미지를 삭제하시겠습니까?",
                    message: nil,
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "삭제", style: .default, handler: { action in
                    self?.Images.remove(at: index!)
                    self?.imageStackView.removeRow(imageview)
                }))
                
                self?.present(alert, animated: true)
                
            }
        }
    }
}

