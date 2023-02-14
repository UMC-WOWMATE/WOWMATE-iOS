//
//  FindPasswordVC.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/20.
//

import UIKit

class FindPasswordVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    private var userEmail: String? = nil
    private var validationCode: String? = nil
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var schoolEmailTextField: UITextField!
    @IBOutlet weak var confirmCodeButton: UIButton!
    @IBOutlet weak var certificationCodeTextField: UITextField!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    
    @IBOutlet weak var sendCertificationCodeButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotification()
        setUpLayout()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    @IBAction func didTapBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapCloseButton(_ sender: UIBarButtonItem) {
        // rootView로 이동
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else { return }
        loginVC.modalPresentationStyle = .fullScreen
        
        present(loginVC, animated: true)
    }
    
    @IBAction func didTapSendCertificationCodeButton(_ sender: UIButton) {
        if let email = schoolEmailTextField.text {
            AuthManager.shared.emailValidationRequest(email: email) { [weak self] result in
                switch result {
                case .success(let success):
                    self?.validationCode = success
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    @IBAction func didTapConfirmCodeButton(_ sender: UIButton) {
        if let code = validationCode {
            if code == certificationCodeTextField.text {
                showEmailValidationToast(isValid: code == certificationCodeTextField.text)
                userEmail = schoolEmailTextField.text!
            }
        }
    }
    
    @IBAction func didTapChangePasswordButton(_ sender: UIButton) {
        // 비밀번호 변경 성공 여부에 따른 다음 화면 전환 구현 예저
        print("did Tap ChangePasswordButton")
        
        let newPassword = confirmNewPasswordTextField.text
        AuthManager.shared.changePassword(email: userEmail!, password: newPassword!) { [weak self] result in
            switch result {
            case .success(let success):
                self?.view.makeToast(success)
            case .failure(let error):
                self?.view.makeToast("네트워크 오류")
            }
            
        }
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    private func setNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(passwordTextDidChanged(_:)),
            name: UITextField.textDidChangeNotification,
            object: confirmNewPasswordTextField
        )
    }
    private func setUpLayout() {
        [
            schoolEmailTextField,
            certificationCodeTextField,
            confirmCodeButton,
            newPasswordTextField,
            confirmNewPasswordTextField,
            sendCertificationCodeButton,
            changePasswordButton
        ].forEach {
            $0?.layer.cornerRadius = 15
        }
    }

    private func showEmailValidationToast(isValid: Bool) {
        self.view.makeToast(isValid ? "이메일 인증에 성공하였습니다" : "이메일 인증에 실패하였습니다")
    }
    
    @objc func passwordTextDidChanged(_ notification: Notification) {
        if let firstPasswordInput = newPasswordTextField.text,
           let finalPasswordInput = confirmNewPasswordTextField.text {
            if (firstPasswordInput.count > 0) && (finalPasswordInput.count > 0) {
                if firstPasswordInput == finalPasswordInput {
                    passwordValidationLabel.isHidden = true
                    changePasswordButton.backgroundColor = UIColor(named: "Main00")
                    changePasswordButton.isEnabled = true
                } else {
                    passwordValidationLabel.isHidden = false
                    changePasswordButton.backgroundColor = UIColor(named: "Main01")
                    changePasswordButton.isEnabled = false
                }
            } else {
                changePasswordButton.backgroundColor = UIColor(named: "Main01")
                changePasswordButton.isEnabled = false
            }
        }
    }
}
