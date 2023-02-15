//
//  AgreeTermsVC.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/20.
//

import UIKit

class AgreeTermsVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    var signupInfo: Signup?
    
    @IBOutlet weak var term1TextView: UITextView!
    @IBOutlet weak var term2TextView: UITextView!
    
    @IBOutlet weak var agreeAllTermsButton: UIButton!
    @IBOutlet weak var agreeTerm1Button: UIButton!
    @IBOutlet weak var agreeTerm2Button: UIButton!
    
    @IBOutlet weak var completeJoinButton: UIButton!
    
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpInputNotification()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    @IBAction func didTapAllTermAgreeButton(_ sender: UIButton) {
        agreeAllTermsButton.isSelected = !(agreeAllTermsButton.isSelected)
        
        var settingValue = true
        if !(agreeAllTermsButton.isSelected) { settingValue = false }
        [
            agreeTerm1Button,
            agreeTerm2Button
            
        ].forEach {
            $0?.isSelected = settingValue
        }
    }
    
    @IBAction func didTapAgreeTerm1(_ sender: UIButton) { agreeTerm1Button.isSelected = !(agreeTerm1Button.isSelected) }
    @IBAction func didTapAgreeTerm2(_ sender: UIButton) { agreeTerm2Button.isSelected = !(agreeTerm2Button.isSelected) }
    
    @IBAction func didTapCompleteJoinButton(_ sender: UIButton) {
        // TODO: 입력한 정보를 서버로 POST 하고, 회원가입 완료 여부를 반환받아 이후 처리 구현할 예정
        NotificationCenter.default.removeObserver(self, name: Notification.Name("checkButton1DidChanged"), object: agreeTerm1Button)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("checkButton2DidChanged"), object: agreeTerm2Button)
        
        print(signupInfo)
        
        if let signupInfo = signupInfo {
            AuthManager.shared.signupRequest(user: signupInfo) { [weak self] result in
                switch result {
                case .success(let success):
                    self?.view.makeToast(success["message"] as! String)
                    if success["code"] as? Int == 200 {
                        self?.showLoginVC()
//                        let login = LoginVC()
//                        self?.present(login, animated: true)
//
//                        guard let login = self?.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else { return }
//                        self?.navigationController?.pushViewController(login, animated: true)
                    }
                    else {
                        let alert = UIAlertController(title: nil, message: success["message"] as? String, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default))
                        self?.present(alert, animated: true)
                    }
                    self?.showLoginVC()
                    
                    
//                    self?.view.makeToast(success)
//                    // TODO: 로그인 메인으로 화면 이동
                    
                case .failure(let error):
                    self?.view.makeToast("네트워크 오류")
                }
                
            }
        }
    }
    
    private func showLoginVC() {
//        var storyboard = UIStoryboard.init(name: "Home", bundle: nil)
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else { return }
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    private func setUpLayout() {
        // CheckboxButton Image Setting
        [
            agreeAllTermsButton,
            agreeTerm1Button,
            agreeTerm2Button
            
        ].forEach {
            $0?.backgroundColor = .white
            $0?.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            $0?.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        }
        
        // etc Settings
        [
            term1TextView,
            term2TextView,
            completeJoinButton
        ].forEach {
            $0?.layer.cornerRadius = 10
        }
    }
    
    private func setUpInputNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkButtonDidChanged(_:)),
            name: Notification.Name("checkButton1DidChanged"),
            object: agreeTerm1Button
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkButtonDidChanged(_:)),
            name: Notification.Name("checkButton2DidChanged"),
            object: agreeTerm2Button
        )
    }
    
    @objc func checkButtonDidChanged(_ notification: Notification) {
        if agreeTerm1Button.isSelected && agreeTerm2Button.isSelected {
            completeJoinButton.backgroundColor = UIColor(named: "Main00")
            completeJoinButton.isEnabled = true
        } else {
            completeJoinButton.backgroundColor = UIColor(named: "Main01")
            completeJoinButton.isEnabled = false
        }
    }
    
}
