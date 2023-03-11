//
//  MypageVC.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/08.
//

import UIKit

private let cellID = "myPageCell"


let firstSectionArray = ["내가 작성한 글"]
let secondSectionArray = ["알림 설정", "채팅 설정", "정보 동의 설정"]
let thirdSectionArray = ["앱 버전", "서비스 이용약관", "기타 문의", "탈퇴하기", "로그아웃"]

class MypageVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
//    ---------[Real Use Data]---------
    lazy var withdrawData:WithdrawDataModel = WithdrawDataModel(isSuccess: false, message: "", code: 200)
    
//    ---------[UI components]---------
    let myPageTableView = UITableView()
    
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI 설정
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        hideNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showNavigationBar()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    // UI 관련 함수
    
    func configureUI() {
        view.addSubview(myPageTableView)
        
        myPageTableView.register(myPageCell.self, forCellReuseIdentifier: cellID)
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
        myPageTableView.separatorStyle = .none
        myPageTableView.tableHeaderView = MyPageHeader(frame: CGRect(x: 0, y: 0 , width: view.frame.width, height: 200))
        
        myPageTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
    }
    
    func hideNavigationBar() {
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func showNavigationBar() {
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .black
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // TODO: - 로그인 화면으로 이동
    func moveToLoginVC() {
        let auth = UIStoryboard.init(name: "Auth", bundle: nil)
        guard let authController = auth.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(authController, animated: false)
        
    }
    
    // TODO: - 탈퇴 서버 통신
    func doWithdraw() {
        UserManager.shared.doWithdraw { [self] result in
            switch result {
            case .success(let data):
                self.withdrawData = data

                if data.isSuccess == true {
                    let doneAlert = UIAlertController(title: "", message: "탈퇴 처리가 완료 되었습니다.\n그 동안 서비스를 이용해 주셔서 감사합니다.", preferredStyle: UIAlertController.Style.alert)
                    self.present(doneAlert, animated: true, completion: nil)
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                        doneAlert.dismiss(animated: true, completion: nil)
                        self.moveToLoginVC()
                    })
                    
                } else {
                    let failAlert = UIAlertController(title: "", message: "탈퇴 처리를 실패했습니다. \n고객센터로 문의해주세요.", preferredStyle: UIAlertController.Style.alert)
                    self.present(failAlert, animated: true, completion: nil)
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                        failAlert.dismiss(animated: true, completion: nil)
                    })
                }
                
                print(data)
                
            case .failure(let Error):
                print(Error)
            }
            
        }
    }
    
    // TODO: - 로그아웃
    func doLogout() {
        UserDefaults.standard.set("", forKey: "token")
        
        moveToLoginVC()
    }
    


}

// MARK: - Extensions

extension MypageVC:  UITableViewDataSource {
    // 섹션 개수: 3개
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    // 섹션의 행 수: [섹션 0: 1개, 섹션 1: 3개, 섹션 2: 5개]
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        
        if section == 0 {
            rowNum = firstSectionArray.count
        }else if section == 1 {
            rowNum = secondSectionArray.count
        }else if section == 2 {
            rowNum = thirdSectionArray.count
        }
        return rowNum
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! myPageCell
        
        cell.tintColor = .orange
        cell.accessoryType = .disclosureIndicator
        
        if indexPath.section == 0 {
             cell.settingLabel.text = firstSectionArray[indexPath.row]
        }else if indexPath.section == 1 {
            cell.settingLabel.text = secondSectionArray[indexPath.row]
        }else if indexPath.section == 2 {
            cell.settingLabel.text = thirdSectionArray[indexPath.row]
            if indexPath.row == 0 {
                cell.explainLabel.text = "1.0.0"
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SectionHeader()
        
        if section == 0 {
            header.titleLabel.text = "글 관리"
        }else if section == 1 {
            header.titleLabel.text = "앱 설정"
        }else if section == 2 {
            header.titleLabel.text = "이용안내"
        }
        
        return header
    }
    
    
}

extension MypageVC: UITableViewDelegate {
    // MARK: - Setting Size of Section Header and Cells
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let writingController = MyWritingViewController()
            navigationController?.pushViewController(writingController, animated: true)
        }else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                print("\(secondSectionArray[indexPath.row])")
            case 1:
                print("\(secondSectionArray[indexPath.row])")
            case 2:
                print("\(secondSectionArray[indexPath.row])")
            default:
                break
            }
        
        }else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                print("\(thirdSectionArray[indexPath.row])")
            case 1:
                print("\(thirdSectionArray[indexPath.row])")
            case 2:
                print("\(thirdSectionArray[indexPath.row])")
            case 3:
                let leaveAlert = UIAlertController(title: "탈퇴하기", message: "정말 탈퇴 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
                let leaveCancle = UIAlertAction(title: "취소", style: .default, handler: nil)
                let leaveOk = UIAlertAction(title: "탈퇴하기", style: .destructive, handler: { [self]
                    action in
                    
                    print("탈퇴!")
                })
                leaveAlert.addAction(leaveCancle)
                leaveAlert.addAction(leaveOk)
                present(leaveAlert, animated: true, completion: nil)
            case 4:
                let logAlert = UIAlertController(title: "로그아웃", message: "정말 로그아웃 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
                let logCancle = UIAlertAction(title: "취소", style: .default, handler: nil)
                let logOk = UIAlertAction(title: "로그아웃", style: .destructive, handler: { [self]
                    action in
                    
                    print("로그아웃!")
                    
                    self.doLogout()
                    
                })
                logAlert.addAction(logCancle)
                logAlert.addAction(logOk)
                present(logAlert, animated: true,completion: nil)
            default:
                break
            }
        }
        
    }
    
}
