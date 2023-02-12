//
//  JoinVC.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/20.
//

import UIKit
import Toast

private let TEMP_EMAIL_DOMAIN = "gmail.com" // 데모데이 시연용 임시 이메일 도메인

class JoinVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
//    private let signupDataManager: SignupDataManager
    private var validationCode: String? = nil
    private var inputEmail: String?
    private var inputPassword: String?
    
    private var completeAllButtonEnable: Bool = false
    
    
    @IBOutlet weak var selectSchoolButton: UIButton!
    
    @IBOutlet weak var inputEmailHeadTextField: UITextField!
    @IBOutlet weak var schoolEmailTextField: UITextField!
    
    @IBOutlet weak var certificationCodeTextField: UITextField!
    
    @IBOutlet weak var firstInputPassWordTextField: UITextField!
    @IBOutlet weak var finalInputPassWordTextField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    
    @IBOutlet weak var sendCertificationCodeButton: UIButton!
    @IBOutlet weak var certificateButton: UIButton!
    @IBOutlet weak var completeAllButton: UIButton!
    
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpInputNotification()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    @IBAction func didTapBackButton(_ sender: UIButton) { dismiss(animated: true) }

    @IBAction func didTapSelectSchoolButton(_ sender: UIButton) {
        print("didTapSelectSchoolButton")
        guard let selectSchoolPopUpVC = storyboard?.instantiateViewController(withIdentifier: "SelectSchoolPopUpVC") as? SelectSchoolPopUpVC else { return }
        selectSchoolPopUpVC.delegate = self
        selectSchoolPopUpVC.modalPresentationStyle = .fullScreen
        
        present(selectSchoolPopUpVC, animated: true)
    }
    
    @IBAction func didTapSendCertificationCodeButton(_ sender: UIButton) {
        if let emailHead = inputEmailHeadTextField.text {
            let inputEmail = emailHead + "@" + TEMP_EMAIL_DOMAIN
            HomeManager.shared.emailValidationRequest(email: inputEmail) { [weak self] result in
                switch result {
                case .success(let success):
                    print(success)
                    self?.validationCode = success
                    self?.inputEmail = inputEmail
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    @IBAction func didTapCertificateButton(_ sender: UIButton) {
        if let code = validationCode {
            showEmailValidationToast(isValid: code == certificationCodeTextField.text)
        }
    }
    
    @IBAction func didTapCompleteAllButton(_ sender: UIButton) {
        // TODO: 입력 정보 모두 저장한채로 InputUserInfoVC로 넘어가기
        SignupDataManager.shared.saveEmailPw(email: inputEmail!, password: inputPassword!)
        
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: inputEmailHeadTextField)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: certificationCodeTextField)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: finalInputPassWordTextField)

        guard let inputUserInfoVC = storyboard?.instantiateViewController(withIdentifier: "InputUserInfoVC") as? InputUserInfoVC else { return }
        inputUserInfoVC.modalPresentationStyle = .fullScreen
        present(inputUserInfoVC, animated: true)
    }
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의

    private func setUpLayout() {
        // set up Buttons layout
        selectSchoolButton.layer.borderWidth = 0.5
        selectSchoolButton.layer.borderColor = UIColor.gray.cgColor
        
        [
            selectSchoolButton,
            sendCertificationCodeButton,
            certificateButton,
            completeAllButton
        ].forEach {
            $0?.layer.cornerRadius = 15
        }
    }
    
    private func setUpInputNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(emailHeadTextDidChanged(_:)),
            name: UITextField.textDidChangeNotification,
            object: inputEmailHeadTextField
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(certificationCodeTextDidChanged(_:)),
            name: UITextField.textDidChangeNotification,
            object: certificationCodeTextField
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(passwordTextDidChanged(_:)),
            name: UITextField.textDidChangeNotification,
            object: finalInputPassWordTextField
        )
    }
    
    private func showEmailValidationToast(isValid: Bool) {
        self.view.makeToast(isValid ? "이메일 인증에 성공하였습니다" : "이메일 인증에 실패하였습니다")
    }
    
    @objc func emailHeadTextDidChanged(_ notification: Notification) {
        if let emailHead = inputEmailHeadTextField.text {
            if emailHead.count > 0 {
                sendCertificationCodeButton.backgroundColor = UIColor(named: "Main00")
                sendCertificationCodeButton.isEnabled = true
            } else {
                sendCertificationCodeButton.backgroundColor = UIColor(named: "Main01")
                sendCertificationCodeButton.isEnabled = false
            }
        }
    }
    
    @objc func certificationCodeTextDidChanged(_ notification: Notification) {
        if let certificationCode = certificationCodeTextField.text {
            if certificationCode.count > 0 {
                certificateButton.backgroundColor = UIColor(named: "Main00")
                certificateButton.isEnabled = true
            } else {
                certificateButton.backgroundColor = UIColor(named: "Main01")
                certificateButton.isEnabled = false
            }
        }
    }
    
    @objc func passwordTextDidChanged(_ notification: Notification) {
        if let firstPasswordInput = firstInputPassWordTextField.text,
           let finalPasswordInput = finalInputPassWordTextField.text {
            if (firstPasswordInput.count > 0) && (finalPasswordInput.count > 0) {
                if firstPasswordInput == finalPasswordInput {
                    passwordValidationLabel.isHidden = true
                    completeAllButton.backgroundColor = UIColor(named: "Main00")
                    completeAllButton.isEnabled = true
                } else {
                    passwordValidationLabel.isHidden = false
                    completeAllButton.backgroundColor = UIColor(named: "Main01")
                    completeAllButton.isEnabled = false
                }
            } else {
                completeAllButton.backgroundColor = UIColor(named: "Main01")
                completeAllButton.isEnabled = false
            }
        }
    }

}

extension JoinVC: SelectSchoolDelegate {
    func selectSchool(_ selected: String) {
//        schoolEmailTextField.text = selected
        schoolEmailTextField.text = "gmail.com" // 인증메일 전송 관련 이슈가 해결될 때까지 임시 처리
    }
}
