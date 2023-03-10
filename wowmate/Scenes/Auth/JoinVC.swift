//
//  JoinVC.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/20.
//

import UIKit
import Toast
import JGProgressHUD

private let TEMP_EMAIL_DOMAIN = "gmail.com" // 데모데이 시연용 임시 이메일 도메인

class JoinVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    var signupInfo: Signup = Signup()
    
    private var timer: DispatchSourceTimer?
    private var duration = 180
    
    private var validationCode: String? = nil
    private var inputEmail: String?
    private var inputPassword: String?
    private var selectedUniv: String?
    private var selectedUnivEmailDomain: String?
    
    private var completeAllButtonEnable: Bool = false
    
    @IBOutlet weak var selectSchoolButton: UIButton!
    
    @IBOutlet weak var inputEmailHeadTextField: UITextField!
    @IBOutlet weak var schoolEmailTextField: UITextField!
    
    @IBOutlet weak var certificationCodeTextField: UITextField!
    
    @IBOutlet weak var firstInputPassWordTextField: UITextField!
    @IBOutlet weak var finalInputPassWordTextField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    
    @IBOutlet weak var sendCertificationCodeButton: UIButton!
    @IBOutlet weak var certificationCountingLabel: UILabel!
    @IBOutlet weak var certificateButton: UIButton!
    @IBOutlet weak var completeAllButton: UIButton!
    
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpInputNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let univ = selectedUniv { selectSchoolButton.setTitle(univ, for: .normal) }
    }

    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의

    @IBAction func didTapSelectSchoolButton(_ sender: UIButton) {
        
        guard let selectSchoolPopUpVC = storyboard?.instantiateViewController(withIdentifier: "SelectSchoolPopUpVC") as? SelectSchoolPopUpVC else { return }
        selectSchoolPopUpVC.delegate = self
        selectSchoolPopUpVC.modalPresentationStyle = .fullScreen
        
        present(selectSchoolPopUpVC, animated: true)
    }
    
    @IBAction func didTapSendCertificationCodeButton(_ sender: UIButton) {
        DispatchQueue.main.async {
            
            if let emailHead = self.inputEmailHeadTextField.text,
               let emailDomain = self.selectedUnivEmailDomain {
                
                // Button Title Setting
                self.sendCertificationCodeButton.setTitle("재전송", for: .normal)
                
                // Loading Animation Setting
                let hud = JGProgressHUD()
                hud.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
                hud.style = .light
                hud.textLabel.text = "인증코드 발송 요청 중"
                hud.show(in: self.view)
                
                // Request Sending Email
                let inputEmail = emailHead + "@" + emailDomain
                AuthManager.shared.emailValidationRequest(email: inputEmail) { [weak self] result in

                    hud.dismiss()
                    
                    switch result {
                    case .success(let success):
                        self?.view.makeToast("인증 메일이 발송되었습니다", duration: 1.0, position: .center)
                        self?.validationCode = success
                        self?.inputEmail = inputEmail
                        self?.certificationCountingLabel.isHidden = false
                        self?.startCounting()
                        
                    case .failure(let failure):
                        print(failure)
                        self?.view.makeToast("인증 메일이 발송에 실패하였습니다", duration: 1.0, position: .center)
                    }
                }
            } else {
                self.view.makeToast("학교를 선택해주세요", duration: 1.5, position: .center)
            }
        }
    }
    
    @IBAction func didTapCertificateButton(_ sender: UIButton) {
        if let code = validationCode {
            if code == certificationCodeTextField.text {
                signupInfo.email = inputEmail!
                signupInfo.school = selectedUniv!
                showEmailValidationToast(isValid: true)
                certificationCountingLabel.isHidden = true
                
                sendCertificationCodeButton.backgroundColor = UIColor(named: "Main01")
                certificateButton.backgroundColor = UIColor(named: "Main01")
                sendCertificationCodeButton.isEnabled = false
                certificateButton.isEnabled = false
            } else {
                showEmailValidationToast(isValid: false)
                certificationCountingLabel.isHidden = false
            }
        } else {
            self.view.makeToast("인증코드가 만료되었습니다. 재요청 바랍니다.", duration: 1.0, position: .center)
        }
    }
    
    @IBAction func didTapCompleteAllButton(_ sender: UIButton) {
        setSignupInfo()
        print(signupInfo)   // for test
        
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: inputEmailHeadTextField)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: certificationCodeTextField)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: finalInputPassWordTextField)

        
        guard let inputUserInfoVC = storyboard?.instantiateViewController(withIdentifier: "InputUserInfoVC") as? InputUserInfoVC else { return }
        inputUserInfoVC.signupInfo = signupInfo
        navigationController?.pushViewController(inputUserInfoVC, animated: true)
    }
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의

    private func setUpLayout() {
        navigationController?.isNavigationBarHidden = false
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
        self.view.makeToast(isValid ? "이메일 인증에 성공하였습니다" : "이메일 인증에 실패하였습니다",
                            duration: 1.0, position: .center)
    }
    
    private func setSignupInfo() {
        // 테스트 지메일 계정으로 회원가입을 해버려서,,임시처리,,
        if let _ = schoolEmailTextField.text,
            let _ = selectedUniv {
            signupInfo.email = inputEmailHeadTextField.text! + schoolEmailTextField.text!
            signupInfo.school = selectedUniv!
        } else {
            self.view.makeToast("학교를 선택해주세요", duration: 1.5, position: .center)
        }

        
        
        signupInfo.password = finalInputPassWordTextField.text!
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
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
        selectedUniv = selected
        schoolImgUrl.keys.forEach {
            if selectedUniv! == $0 { signupInfo.imgUrl = schoolImgUrl[$0]! }
        }
    }
    
    func selectSchoolDomain(_ selected: String) {
        selectedUnivEmailDomain = selected
        schoolEmailTextField.text = selected
    }
}
