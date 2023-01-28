 //
//  MyWritingViewController.swift
//  wowmate
//
//  Created by 장윤정 on 2023/01/19.
//

import UIKit

class MyWritingViewController: UIViewController {

    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    let label: UILabel = {
        let label = UILabel()
        label.text = "내가 작성한 글"
        return label
    }()
    
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(label)
        label.centerX(inView: view)
        label.centerY(inView: view)
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
}
