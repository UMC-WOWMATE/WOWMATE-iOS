//
//  LoginVC.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/08.
//

import UIKit
import Toast

class LoginVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    // 서버로 보낼 데이터를 위한 변수
    private var isMaintainLoginStatus: Bool = false
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var maintainLoginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setUpLayouts()
        setUpInputNotification()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    
    @IBAction func didTapLoginStatusMaintainButton(_ sender: UIButton) {
        isMaintainLoginStatus = true
        maintainLoginButton.isSelected = !(maintainLoginButton.isSelected)
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: emailTextField)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: passwordTextField)
        
        // TODO: 로그인 성공 여부에 따라 HomeVC로 전환하거나, 로그인 실패 Alert 띄우기 (로그인 성공할 경우에 notification remove observer하도록 수정)
        if let inputEmail = emailTextField.text,
           let inputPassword = passwordTextField.text {
            let login = Login(email: inputEmail, password: inputPassword)
            AuthManager.shared.signinRequest(user: login) { [weak self] result in
                switch result {
                case .success(let success):
                    print(success)
                    self?.view.makeToast("로그인 성공", duration: 1.0, position: .center)
                    if success["code"] as? Int == 200 {
                        self?.navigationController?.pushViewController(MainTabVC(), animated: true)
                    }
                case .failure(let _):
                    self?.view.makeToast("로그인 실패")
                    return
                }
            }
        }
        
        
    }
    
    @IBAction func didTapFindPasswordButton(_ sender: UIButton) {
        // FindPasswordVC로 넘어가기
        guard let findPasswordVC = storyboard?.instantiateViewController(withIdentifier: "FindPasswordVC") as? FindPasswordVC else { return }
        findPasswordVC.modalPresentationStyle = .fullScreen
        
        present(findPasswordVC, animated: true)
        
    }
    
    @IBAction func didTapJoinButton(_ sender: UIButton) {
        guard let joinVc = storyboard?.instantiateViewController(withIdentifier: "JoinVC") as? JoinVC else { return }
        navigationController?.pushViewController(joinVc, animated: true)
    }
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    private func setUpLayouts() {
        maintainLoginButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        maintainLoginButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        loginButton.layer.cornerRadius = 10
    }
    private func setUpInputNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChanged(_:)),
            name: UITextField.textDidChangeNotification,
            object: emailTextField
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChanged(_:)),
            name: UITextField.textDidChangeNotification,
            object: passwordTextField
        )
    }
    
    @objc func textDidChanged(_ notification: Notification) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if (email.count > 0) && (password.count > 0) {
                loginButton.backgroundColor = UIColor(named: "Main00")
                loginButton.isEnabled = true
            } else {
                loginButton.backgroundColor = UIColor(named: "Main01")
                loginButton.isEnabled = false
            }
        }
    }
    
    // MARK: functions about data fetch and validate
    
    
}
