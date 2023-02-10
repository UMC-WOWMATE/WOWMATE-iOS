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
    @IBAction func didTapBackButton(_ sender: UIButton) { dismiss(animated: true) }
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
            name: Notification.Name("checkButtonDidChanged"),
            object: nil
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
