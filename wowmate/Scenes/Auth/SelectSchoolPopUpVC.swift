//
//  SelectSchoolPopUpVC.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/22.
//

import UIKit
import Toast

protocol SelectSchoolDelegate: AnyObject {
    func selectSchool(_ selected: String)   // 선택된 셀의 학교명을 전달할 예정
    func selectSchoolDomain(_ selected: String)   // 선택된 셀의 학교 메일 도메인을 전달할 예정
}

class SelectSchoolPopUpVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    weak var delegate: SelectSchoolDelegate?
    private var selectedSchool: String?
    private var selectedSchoolEmail: String?

    private let schoolEmailArray = schoolEmailDomain
    
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
        delegate?.selectSchoolDomain(selectedSchoolEmail ?? "")
        delegate?.selectSchool(selectedSchool ?? "")
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
        selectedSchool = schoolEmailArray[indexPath.row][0]
        selectedSchoolEmail = schoolEmailArray[indexPath.row][1]
    }
}

