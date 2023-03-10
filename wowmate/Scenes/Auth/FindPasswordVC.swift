//
//  FindPasswordVC.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/20.
//

import UIKit
import Toast
import JGProgressHUD

class FindPasswordVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    private var timer: DispatchSourceTimer?
    private var duration = 180
    
    private var isValid = false
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
    @IBOutlet weak var certificationCountingLabel: UILabel!
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
    @IBAction func didTapCloseButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTapSendCertificationCodeButton(_ sender: UIButton) {
        DispatchQueue.main.async {
            
            if let email = self.schoolEmailTextField.text {
                
                // Button Title Setting
                self.sendCertificationCodeButton.setTitle("재전송", for: .normal)
                
                // Loading Animation Setting
                let hud = JGProgressHUD()
                hud.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
                hud.style = .light
                hud.textLabel.text = "인증코드 발송 요청 중"
                hud.show(in: self.view)
                
                AuthManager.shared.emailValidationRequest(email: email) { [weak self] result in
                    hud.dismiss()
                    
                    switch result {
                    case .success(let success):
                        self?.view.makeToast("인증 메일이 발송되었습니다", duration: 1.0, position: .center)
                        self?.validationCode = success
                        self?.userEmail = email
                        self?.certificationCountingLabel.isHidden = false
                        self?.startCounting()
                    case .failure(let failure):
                        print(failure)
                        self?.view.makeToast("인증 메일이 발송에 실패하였습니다", duration: 1.0, position: .center)
                    }
                }
            } else {
                self.view.makeToast("이메일을 입력해주세요", duration: 1.5, position: .center)
            }

        }
    }
    
    @IBAction func didTapConfirmCodeButton(_ sender: UIButton) {
        if let code = validationCode {
            if code == certificationCodeTextField.text {
                isValid = true
                showEmailValidationToast(isValid: code == certificationCodeTextField.text)
                userEmail = schoolEmailTextField.text!
                
                certificationCountingLabel.isHidden = true
                sendCertificationCodeButton.backgroundColor = UIColor(named: "Main01")
                confirmCodeButton.backgroundColor = UIColor(named: "Main01")
                sendCertificationCodeButton.isEnabled = false
                confirmCodeButton.isEnabled = false
            }
        }
    }
    
    @IBAction func didTapChangePasswordButton(_ sender: UIButton) {
        if isValid {
            if let email = userEmail,
               let password = confirmNewPasswordTextField.text {
                AuthManager.shared.changePassword(email: email, password: password) { [weak self] result in
                    switch result {
                    case .success(let success):
                        self?.view.makeToast(success, duration: 1.5, position: .center)
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                        self?.view.makeToast("비밀번호 변경 실패", duration: 1.5, position: .center)
                    }
                    
                }
            } else {
                self.view.makeToast("정보를 모두 기입해주세요", duration: 1.5, position: .center)
            }
            
        } else {
            self.view.makeToast("이메일 인증이 필요합니다", duration: 1.5, position: .center)
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
        self.view.makeToast(isValid ? "이메일 인증에 성공하였습니다" : "이메일 인증에 실패하였습니다", duration: 1.5, position: .center)
    }
    
    private func startCounting() {
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler { [weak self] in
                guard let self = self else { return }
                self.duration -= 1
                let min = self.duration / 60
                let sec = (self.duration % 60) % 60
                self.certificationCountingLabel.text = String(format: "%02d:%02d", min, sec)
                
                if self.duration <= 0{
                    self.timer?.cancel()
                    self.timer = nil    // 타이머 해제
                    self.validationCode = nil   // 생성된 인증코드 무효화
                    self.certificationCountingLabel.isHidden = true
                    self.duration = 180
                }
            }
            self.timer?.resume()
        }
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
