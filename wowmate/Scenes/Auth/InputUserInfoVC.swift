//
//  InputUserInfoVC.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/20.
//

import UIKit

class InputUserInfoVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    var signupInfo: Signup?
    
    var gender: String?
    var birth: String?
    var phoneNum: String?
    
    
    private let birthDataPicker = UIDatePicker()
    
    @IBOutlet weak var birthTextField: UITextField!
    
    @IBOutlet weak var sexSelectButton: UIButton!
    @IBOutlet weak var phoneNumTextField: UITextField!
    
    @IBOutlet weak var completeAllButton: UIButton!
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBirthInputView()
        setUpLayout()
        setUpSelectSexPopUpButton()
        setUpInputNotification()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    @IBAction func didTapBackButton(_ sender: UIButton) { dismiss(animated: true) }
        
    @IBAction func didEndEditingBirthTExtField(_ sender: UITextField) { sender.textColor = .black }
    
    
    @IBAction func didSelectedSexButton(_ sender: UIButton) { }
    
    
    @IBAction func didTapCompleteAllButton(_ sender: UIButton) {
        // 입력 조건 모두 확인하고, 조건이 모두 충족하면 InputUserInfoVC로 넘어가기
        // 입력 조건 불충족 시, Alert 띄우기
        setSignupInfo()
        print(signupInfo)
        
        guard let agreeTermsVC = storyboard?.instantiateViewController(withIdentifier: "AgreeTermsVC") as? AgreeTermsVC else { return }
        agreeTermsVC.signupInfo = signupInfo
        navigationController?.pushViewController(agreeTermsVC, animated: true)
    }

    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    private func setUpBirthInputView() {
        birthDataPicker.datePickerMode = .date
        birthDataPicker.preferredDatePickerStyle = .wheels
        birthDataPicker.addTarget(
            self,
            action: #selector(birthDatePickerValueChanged(_:)),
            for: .valueChanged
        )
        birthTextField.inputView = birthDataPicker
    }
    
    private func setUpLayout() {
        // set up Buttons layout
        sexSelectButton.setImage(nil, for: .selected)

        sexSelectButton.layer.borderWidth = 0.5
        sexSelectButton.layer.borderColor = UIColor.gray.cgColor
        [
            phoneNumTextField,
            sexSelectButton,
            completeAllButton
        ].forEach {
            $0?.layer.cornerRadius = 15
        }
    }
    
    private func setSexButtonSelectedLayout() {
        sexSelectButton.isSelected = !(sexSelectButton.isSelected)
    }
    
    private func setUpSelectSexPopUpButton() {
        let man = UIAction(title: "남성", image: nil, handler: { [weak self] _ in
            self?.setSexButtonSelectedLayout()
            self?.gender = "M"
            print("gender set :: \(self?.gender)")
        })
        let woman = UIAction(title: "여성", image: nil, handler: { [weak self] _ in
            self?.setSexButtonSelectedLayout()
            self?.gender = "F"
            print("gender set :: \(self?.gender)")
        })

        sexSelectButton.menu = UIMenu(
            title: "성별을 선택해주세요",
            image: nil,
            identifier: nil,
            options: .displayInline,
            children: [man, woman]
        )
        sexSelectButton.showsMenuAsPrimaryAction = true
        sexSelectButton.changesSelectionAsPrimaryAction = true
    }
    
    private func setUpInputNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChanged(_:)),
            name: UITextField.textDidChangeNotification,
            object: birthTextField
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChanged(_:)),
            name: UITextField.textDidChangeNotification,
            object: phoneNumTextField
        )
    }
    
    private func setSignupInfo() {
        phoneNum = phoneNumTextField.text
        
        if let birth = self.birth,
           let gender = self.gender,
           let phoneNum = self.phoneNum {
            
            signupInfo?.birth = birth
            signupInfo?.gender = gender
            signupInfo?.phoneNumber = phoneNum
        }
    }
    
    
    // objc methods
    @objc private func birthDatePickerValueChanged(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        birthTextField.text = formatter.string(from: birthDataPicker.date)
        
        birth = birthTextField.text
        print("birth set :: \(birth)")
    }
    
    @objc func textDidChanged(_ notification: Notification) {
        if let birth = birthTextField.text, let phoneNumber = phoneNumTextField.text {
            if (birth.count > 0) && (phoneNumber.count > 0) {
                completeAllButton.backgroundColor = UIColor(named: "Main00")
                completeAllButton.isEnabled = true
            } else {
                completeAllButton.backgroundColor = UIColor(named: "Main01")
                completeAllButton.isEnabled = false
            }
        }
    }
}
