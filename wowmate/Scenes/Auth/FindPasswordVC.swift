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
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var schoolEmailTextField: UITextField!
    @IBOutlet weak var certificationCodeTextField: UITextField!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    
    @IBOutlet weak var sendCertificationCodeButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
    }
    
    @IBAction func didTapChangePasswordButton(_ sender: UIButton) {
        // 비밀번호 변경 성공 여부에 따른 다음 화면 전환 구현 예저
        print("did Tap ChangePasswordButton")
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    private func setUpLayout() {
        [
            schoolEmailTextField,
            certificationCodeTextField,
            newPasswordTextField,
            confirmNewPasswordTextField,
            sendCertificationCodeButton,
            changePasswordButton
        ].forEach {
            $0?.layer.cornerRadius = 15
        }
    }

}
