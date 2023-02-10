//
//  JoinVC.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/20.
//

import UIKit

class JoinVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
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
        // TODO: 이메일로 인증번호 전송 처리
    }
    
    @IBAction func didTapCertificateButton(_ sender: UIButton) {
        // TODO: 입력된 인증번호가 유효한지 검증 처리
    }
    
    @IBAction func didTapCompleteAllButton(_ sender: UIButton) {
        // TODO: 입력 정보 모두 저장한채로 InputUserInfoVC로 넘어가기
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
    func selectSchool(_ selected: String) { schoolEmailTextField.text = selected }
}
