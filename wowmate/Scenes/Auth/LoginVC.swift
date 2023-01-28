//
//  LoginVC.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/08.
//

import UIKit

class LoginVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    // 서버로 보낼 데이터를 위한 변수
    private var inputEmail: String? = nil
    private var inputPassword: String? = nil
    private var isMaintainLoginStatus: Bool = false
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var maintainLoginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayouts()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    
    @IBAction func didTapLoginStatusMaintainButton(_ sender: UIButton) {
        isMaintainLoginStatus = true
        maintainLoginButton.isSelected = !(maintainLoginButton.isSelected)
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        // 입력된 이메일 & 비밀번호 정보를 서버로 전달
        // 로그인 성공 여부에 따라 HomeVC로 전환하거나, 로그인 실패 Alert 띄우기
    }
    
    @IBAction func didTapFindPasswordButton(_ sender: UIButton) {
        // FindPasswordVC로 넘어가기
        guard let findPasswordVC = storyboard?.instantiateViewController(withIdentifier: "FindPasswordVC") as? FindPasswordVC else { return }
        findPasswordVC.modalPresentationStyle = .fullScreen
        
        present(findPasswordVC, animated: true)
    }
    
    @IBAction func didTapJoinButton(_ sender: UIButton) {
        // JoinVC로 넘어가기
        guard let joinVC = storyboard?.instantiateViewController(withIdentifier: "JoinVC") as? JoinVC else { return }
        joinVC.modalPresentationStyle = .fullScreen
        
        present(joinVC, animated: true)
    }
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    private func setUpLayouts() {
        maintainLoginButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        maintainLoginButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        loginButton.layer.cornerRadius = 10
    }
    
}
