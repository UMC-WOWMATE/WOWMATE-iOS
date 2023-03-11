//
//  InputUserInfoVC.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/20.
//

import UIKit
import Toast

class InputUserInfoVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    var signupInfo: Signup?
    
    var gender: String?
//    var birth: String?
//    var phoneNum: String?
    
    
    private let birthDatePicker = UIDatePicker()
    
    @IBOutlet weak var birthTextField: UITextField!
    
    @IBOutlet weak var genderSelectButton: UIButton!
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
    @IBAction func didEndEditingBirthTExtField(_ sender: UITextField) { sender.textColor = .black }
    
    @IBAction func didSelectedGenderButton(_ sender: UIButton) { }
    
    @IBAction func didTapCompleteAllButton(_ sender: UIButton) {
        // 입력 조건 모두 확인하고, 조건이 모두 충족하면 InputUserInfoVC로 넘어가기
        // 입력 조건 불충족 시, Alert 띄우기
        if setSignupInfo() {
            NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: birthTextField)
            NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: phoneNumTextField)
            
            guard let agreeTermsVC = storyboard?.instantiateViewController(withIdentifier: "AgreeTermsVC") as? AgreeTermsVC else { return }
            agreeTermsVC.signupInfo = signupInfo
            navigationController?.pushViewController(agreeTermsVC, animated: true)
            
        } else {
            self.view.makeToast("정보를 모두 기입해주세요", duration: 1.5, position: .center)
        }
    }

    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    private func setUpBirthInputView() {
        birthDatePicker.datePickerMode = .date
        birthDatePicker.preferredDatePickerStyle = .wheels
        birthDatePicker.addTarget(
            self,
            action: #selector(birthDatePickerValueChanged(_:)),
            for: .valueChanged
        )
        birthTextField.inputView = birthDatePicker
    }
    
    private func setUpLayout() {
        // set up Buttons layout
        genderSelectButton.setImage(nil, for: .selected)

        genderSelectButton.layer.borderWidth = 0.5
        genderSelectButton.layer.borderColor = UIColor.gray.cgColor
        [
            phoneNumTextField,
            genderSelectButton,
            completeAllButton
        ].forEach {
            $0?.layer.cornerRadius = 15
        }
    }
    
    private func setSexButtonSelectedLayout() {
        genderSelectButton.isSelected = !(genderSelectButton.isSelected)
    }
    
    private func setUpSelectSexPopUpButton() {
        let man = UIAction(title: "남성", image: nil, handler: { [weak self] _ in
            self?.setSexButtonSelectedLayout()
            self?.gender = "M"
            self?.genderSelectButton.setTitle("남성", for: .normal)
        })
        let woman = UIAction(title: "여성", image: nil, handler: { [weak self] _ in
            self?.setSexButtonSelectedLayout()
            self?.gender = "F"
            self?.genderSelectButton.setTitle("여성", for: .normal)
        })

        genderSelectButton.menu = UIMenu(
            title: "성별을 선택해주세요",
            image: nil,
            identifier: nil,
            options: .displayInline,
            children: [man, woman]
        )
        genderSelectButton.showsMenuAsPrimaryAction = true
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(phoneNumTextDidChanged(_:)),
            name: UITextField.textDidChangeNotification,
            object: phoneNumTextField
        )
    }
    
    private func setSignupInfo() -> Bool {
        if var phoneNum =  phoneNumTextField.text,
           let birth = birthTextField.text ,
           let gender = gender {
            
            signupInfo?.birth = birth
            signupInfo?.gender = gender

            if phoneNum.count > 11 {
                self.view.makeToast("전화번호를 확인해주세요", duration: 1.5, position: .center)
                return false
            }
            
            if phoneNum.contains("-") { phoneNum = phoneNum.trimmingCharacters(in: ["-"]) }
            signupInfo?.phoneNumber = phoneNum
            
            return true
        } else { return false }
    }
    
    
    // objc methods
    @objc private func birthDatePickerValueChanged(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        birthTextField.text = formatter.string(from: birthDatePicker.date)
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
    
    @objc func phoneNumTextDidChanged(_ notification: Notification) {
        // TODO: 010-0000-0000 형태로 표시
    }
}
