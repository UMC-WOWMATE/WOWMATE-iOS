//
//  SelectSchoolPopUpVC.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/22.
//

import UIKit

protocol SelectSchoolDelegate: AnyObject {
    func selectSchool(_ selected: String)   // 선택된 셀의 학교명을 전달할 예정
}

class SelectSchoolPopUpVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    weak var delegate: SelectSchoolDelegate?
    private var selectedSchoolEmail: String?
    
    // 있는 척을 위한,,학교 이름,이메일 임시 데이터,,아 직접입력도 넣어야 하나
    private let schoolEmailArray: [[String]] = [
        ["명지대학교","mju.ac.kr"],
        ["홍익대학교","hongik.ac.kr"],
        ["숙명여자대학교","sookmyung.ac.kr"],
        ["성신여자대학교","sungsin.ac.kr"],
        ["서울대학교","snu.ac.kr"],
        ["연세대학교","yonsei.ac.kr"],
        ["고려대학교","korea.ac.kr"],
        ["서강대학교","sogang.ac.kr"],
        ["성균관대학교","skku.edu"],
        ["중앙대학교","cau.ac.kr"],
        ["경희대학교","khu.ac.kr"],
        ["한국외국어대학교","hufs.ac.kr"],
        ["서울시립대학교","uos.ac.kr"],
    ]
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var schoolTableView: UITableView!
    @IBOutlet weak var selectButton: UIButton!
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpLayout()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    @IBAction func didTapSelectButton(_ sender: UIButton) {
        delegate?.selectSchool(selectedSchoolEmail ?? "")
        dismiss(animated: true)
    }
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    private func setUp() {
        schoolTableView.dataSource = self
        schoolTableView.delegate = self
    }
    
    private func setUpLayout() {
        contentView.layer.cornerRadius = 20
        selectButton.layer.cornerRadius = 15
    }
}

extension SelectSchoolPopUpVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolTableViewCell", for: indexPath) as? SchoolTableViewCell else { return UITableViewCell() }
        
        cell.schoolName.text = schoolEmailArray[indexPath.row][0]
        cell.schoolEmail.text = schoolEmailArray[indexPath.row][1]
        
        return cell
    }
}

extension SelectSchoolPopUpVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSchoolEmail = schoolEmailArray[indexPath.row][1]
    }
}

