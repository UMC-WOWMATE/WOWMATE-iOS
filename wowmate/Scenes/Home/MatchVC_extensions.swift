//
//  MatchVC_extensions.swift
//  wowmate
//
//  Created by 이지웅 on 2023/02/05.
//

import Foundation
import UIKit
import AloeStackView
import YPImagePicker

extension MatchVC: UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    // MARK: - Actions
    @IBAction func closeButtonDidTab(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "글 작성을 취소하시겠습니까?\n모든 변경사항은 폐기됩니다",
            message: nil,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "계속 작성", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "나가기", style: .default, handler: { action in
            print("closed")
//            self.navigationController?.popViewController(animated: true)
            
        }))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func saveButtonDidTab(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "글을 등록하시겠습니까?",
            message: nil,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "등록", style: .default, handler: { action in
            //업로드 통신
            let post = Post_save(postTitle: self.titleTextField.text ?? "제목 없음",
                                 categoryName: self.List_of_Category[self.categoryPickerView.selectedRow(inComponent: 0)],
                                 postMember: Int(self.memberTextField.text!) ?? 0,
                                 tag1: self.Tags.isEmpty ? nil : self.Tags.removeFirst(),
                                 tag2: self.Tags.isEmpty ? nil : self.Tags.removeFirst(),
                                 tag3: self.Tags.isEmpty ? nil : self.Tags.removeFirst(),
                                 tag4: self.Tags.isEmpty ? nil : self.Tags.removeFirst(),
                                 tag5: self.Tags.isEmpty ? nil : self.Tags.removeFirst(),
                                 postContext: self.contextsTextView.text
//                                 ,
//                                 image1: self.Images.isEmpty ? nil : self.Images.removeFirst().pngData(),
//                                 image2: self.Images.isEmpty ? nil : self.Images.removeFirst().pngData(),
//                                 image3: self.Images.isEmpty ? nil : self.Images.removeFirst().pngData(),
//                                 image4: self.Images.isEmpty ? nil : self.Images.removeFirst().pngData(),
//                                 image5: self.Images.isEmpty ? nil : self.Images.removeFirst().pngData()
            )
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

            do {
                let jsonData = try encoder.encode(post)

                if let jsonStr = String(data: jsonData, encoding: .utf8) {
                    print(jsonStr)
                }
            } catch {
                print(error)
            }
            
            //업로드 통신
            let alert_done = UIAlertController(
                title: "등록 완료",
                message: nil,
                preferredStyle: .alert)
            alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            
            self.present(alert_done, animated: true)
            
            print("saved")
//            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func temsaveButtonDidTab(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "글을 임시저장 하시겠습니까?",
            message: nil,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "임시저장", style: .default, handler: { action in
            let alert_done = UIAlertController(
                title: "임시저장 완료",
                message: nil,
                preferredStyle: .alert)
            alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            
            self.present(alert_done, animated: true)
            print("temsaved")
//            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
    
    
    @IBAction func addTagsButtonDidTab(_ sender: UIButton) {
        if Tags.count >= 5 {
            let alert = UIAlertController(
                title: "태그는 최대 5개까지 등록할 수 있습니다.",
                message: nil,
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
            return
        }
        
        let alert = UIAlertController(title: "태그 추가", message: "# 없이 1개씩 추가해주세요.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))

                alert.addTextField { (textField) in
                    textField.placeholder = "e.g. 축구, 스터디, 룸메이트... "
                }
                
                alert.addAction(UIAlertAction(title: "추가", style: .default, handler: { action in
                    if let name = alert.textFields?.first?.text {
                        self.Tags.append(name)
                        self.showTag()
                    }
                }))

                self.present(alert, animated: true)
        
    }
    
    @IBAction func addPhotosButtonDidTap(_ sender: UIButton) {
        if Images.count >= 5 {
            let alert = UIAlertController(
                title: "이미지는 최대 5개까지 등록할 수 있습니다.",
                message: nil,
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
            return
        }
        
            var config = YPImagePickerConfiguration()
            config.library.maxNumberOfItems = 5 - Images.count
        config.library.mediaType = .photo
        
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, cancelled in
                
                if cancelled {
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
                
                // 여러 이미지를 넣어주기 위해 하나씩 넣어주는 반복문
                for item in items {
                    switch item {
                    // 이미지만 받기때문에 photo case만 처리
                    case .photo(let p):
                        // 이미지를 해당하는 이미지 배열에 넣어주는 code
                        self.Images.append(p.image)
                        
                    default:
                        print("")
                        
                    }
                    
                }
                picker.dismiss(animated: true) {
                    self.showImage()
                }
            }
            
            // picker뷰 present
        present(picker, animated: true, completion: .none)
        
        }
    
    // MARK: - Helpers
    
    //PickerView - Category
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return List_of_Category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return List_of_Category[row]
    }
    
    //TextView - Context
    func textViewDidBeginEditing(_ textView: UITextView) {
            /// 플레이스홀더
            if textView.text.isEmpty {
                contextsTextView.textColor = .gray
                contextsTextView.text = placeholder
            } else if textView.text == placeholder {
                contextsTextView.textColor = .black
                contextsTextView.text = nil
            }
        }
        
    func textViewDidEndEditing(_ textView: UITextView) {
        /// 플레이스홀더
        if textView.text.isEmpty {
            contextsTextView.textColor = .gray
            contextsTextView.text = placeholder
        }
    }
    
}


