//
//  SampleVC.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/08.
//

import UIKit

class SampleVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet

    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    

}

// 콜렉션뷰나 테이블뷰등, 프로토콜이 별도로 있는 경우 extension을 이용해
// 별도로 선언하고, 그 안에 해당하는 메서드를 선언 및 정의
extension SampleVC: UICollectionViewDelegate {
    
}

// 프로토콜이 없더라도 따로 분리해야할 경우 extension으로 선언해줍니다.
extension SampleVC {
    
}
