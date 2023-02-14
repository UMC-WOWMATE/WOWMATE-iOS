//
//  MyPageHeader.swift
//  
//
//  Created by 장윤정 on 2023/01/19.
//

import UIKit

class MyPageHeader: UIView {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
//    ---------[Real Use Data]---------
    lazy var myPageData:MyPageDataModel = MyPageDataModel(isSuccess: true, code: 200, message: "SUCCESS!", data1: userData)
    lazy var userData:User = User(email: "my@sookmyung.ac.kr", univ: "숙명여대", phoneNumber: "010-0000-0000", birth: "2000-10-14", gender: "F", create_date: "2023-02-13 03:19:01.756350")//, image_url: SookImageUrl)
    
//    ---------[UI components]---------
    let imageUrl: String = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC_Varq6a2k-TR670RYQkEfHPGgRYXArbGuw&usqp=CAU"
    let SookImageUrl: String = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzg8B0MB919OvJrv57cUBNlZ7mXUFTxQg0Ww&usqp=CAU"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "계정 설정"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    let introView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.setDimensions(height: 135, width: view.frame.width) // 361
        // 그림자
        view.layer.shadowColor = UIColor.WM.gray600.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        
        let url = URL(string: SookImageUrl)
        imageView.load(url: url!)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        
        imageView.contentMode = .scaleToFill
        imageView.setDimensions(height: 100, width: 100)
        imageView.layer.cornerRadius = (100 / 2)
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.lightGray.cgColor

        return imageView
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        
        label.text = "wowmate@sookmyung.ac.kr"
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    var ageLabel: UILabel = {
        let label = UILabel()
        
        label.text = "나이: 24"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
    var sexLabel: UILabel = {
        let label = UILabel()
        
        label.text = "성별: 여"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
    var phoneNumLabel: UILabel = {
        let label = UILabel()
        
        label.text = "연락처: 010-0000-0000"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
    var signUpDateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "가입일: 2023년 01월 10일"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
    let emptyView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.ageLabel, self.sexLabel])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        return stackView
    }()
    
    lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.emailLabel, self.emptyView, self.hStackView, self.phoneNumLabel, self.signUpDateLabel])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        
        stackView.setDimensions(height: 100, width: (self.frame.width - 180))
        return stackView
    }()
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 데이터 받아오기
        fetchMyPageData()
        
        // UI 설정
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    
    // 화면 배치 함수
    func configureUI() {
        
        addSubview(titleLabel)
        addSubview(introView)
        
        introView.addSubview(profileImage)
        introView.addSubview(emailLabel)
        introView.addSubview(vStackView)

        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 24, paddingLeft: 24)
        
        introView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, paddingTop: 15, paddingLeft: 16, paddingRight: 16)
        introView.centerX(inView: self)
        
        profileImage.anchor(left: introView.leftAnchor, paddingLeft: 18)
        profileImage.centerY(inView: introView)
        
        vStackView.anchor(top: profileImage.topAnchor, left: profileImage.rightAnchor, paddingLeft: 15, paddingRight: 15)
         
        
    }
    
//    ---------[methods for fetching data]---------
    
    // method for getting create_date STRING
    func getCreateDate(_ date:String) -> String {
        let year = date.prefix(4)
        
        let monthStartIndex = date.index(date.startIndex, offsetBy: 5)
        let monthEndIndex = date.index(date.startIndex, offsetBy: 6)
        let month = date[monthStartIndex...monthEndIndex]
        
        let dayStartIndex = date.index(date.startIndex, offsetBy: 8)
        let dayEndIndex = date.index(date.startIndex, offsetBy: 9)
        let day = date[dayStartIndex...dayEndIndex]
        
        return year + "년 " + month + "월 " + day + "일"
    }
    
    // method for calculate age
    func getAge(_ birth: String) -> String {
        guard let year = Int(birth.prefix(4)) else { return "2000"}
        
        let today = Date() // 현재의 Date 날짜 및 시간
        let dayFormatter = DateFormatter() // Day 포맷 객체 선언
        
        dayFormatter.dateFormat = "yyyy" // Day 포맷 타입 지정
        guard let nowYear = Int(dayFormatter.string(from: today)) else { return "2023" } // 포맷된 형식 문자열로 반환
        
        let age = nowYear - year + 1
        
        return String(age)
    }
    
    func getSex(_ english:String) -> String {
        if english == "M" { return "남" }
        else if english == "F" { return "여" }
        else { return "미상"}
    }
    
//    ---------[methods to get data from server]---------
    func fetchMyPageData() {
        
        UserManager.shared.getUserInfo { [self] result in
            switch result {
            case .success(let data):
                self.myPageData = data
                
//                let url = URL(string: self.myPageData.data1.image_url)
//                self.profileImage.load(url: url!)
                
                self.emailLabel.text = self.myPageData.data1.email
                self.ageLabel.text = "나이: " + self.getAge(self.myPageData.data1.birth)
                self.sexLabel.text = "성별: " + self.getSex(self.myPageData.data1.gender)
                self.phoneNumLabel.text = "연락처: " + self.myPageData.data1.phoneNumber
                self.signUpDateLabel.text = "가입일: " + self.getCreateDate(self.myPageData.data1.create_date)
                
                print(data)
                
            case .failure(let Error):
                print(Error)
            }
            
        }
    }
}
