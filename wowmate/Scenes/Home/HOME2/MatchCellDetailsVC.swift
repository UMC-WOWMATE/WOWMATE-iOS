//
//  MatchCellDetailsVC.swift
//  HomeVC_EX
//
//  Created by Dongwan Ryoo on 2023/01/22.
//

import Foundation
import UIKit
import AloeStackView
import Moya

class MatchCellDetailsVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    var id: Int = -1
    var comments: [Comment] = []
//    let commentReplyDtoList: [CommentReply] = []
    
    
    var tagList: [String] = ["수정해주세요","학교","홍익대"]
    
    let UnderLine:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.opacity = 0.3
        return view
    }()
    
    let UnderLine1:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.opacity = 0.3
        return view
    }()
    
    let MatchCellDetailsTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "매칭 제목"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
        
    let MatchCellDetailsAddButton:UIButton = {
       let button = UIButton()
//        button.setImage(UIImage(imageLiteralResourceName: "AddButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(AddButton), for: .allEvents)
        return button
    }()
    
    @objc func AddButton(_ sender:Any){
            let alertAction = UIAlertController(title: "게시글관련 옵션을 취해주세요.", message: "", preferredStyle: UIAlertController.Style.alert)
    
            alertAction.addAction(UIAlertAction(title: "삭제", style: .default))
            alertAction.addAction(UIAlertAction(title: "차단", style: .default))
            alertAction.addAction(UIAlertAction(title: "신고", style: .default))
    
            present(alertAction, animated: true)
        }
    
//    @objc func mainCellAddButton(_ sender:Any){
//        let alertAction = UIAlertController(title: "게시글 관련 액션을 취해주세요.", message: "", preferredStyle: UIAlertController.Style.alert)
//
//        alertAction.addAction(UIAlertAction(title: "삭제", style: .default))
//        alertAction.addAction(UIAlertAction(title: "차단", style: .default))
//        alertAction.addAction(UIAlertAction(title: "신고", style: .default))
//
//       present(alertAction, animated: true)
//    }
//
//    let MainCellAddButton:UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setImage(UIImage(imageLiteralResourceName: "AddButton"), for: .normal)
//        button.addTarget(MainCell.self, action:  #selector(mainCellAddButton), for:.allTouchEvents)
//        return button
//    }()
//
    let MatchCellDetailsDate:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "등록일 : 2022.1.3"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        return label
        
    }()
    
    let MatchCellDetailslike:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let MatchCellDetailslikeCount:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20"
        return label
    }()
    
    
    
    let MatchCellDetailslikecount:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "조회수 : 47"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .right
        return label
    }()
    
    
    
    
//    let MatchCellDetailsCount:UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "00"
//        label.numberOfLines = 1
//        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
//        label.textAlignment = .right
//        return label
//    }()
    
    let MatchCellDetailsViewCount:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "조회수 : 47"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    let container: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
       stackView.spacing = 3
       stackView.axis = .horizontal
       stackView.distribution = .equalSpacing
       return stackView
   }()
    
    let MatchCellDetailsNumber:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "모집인원 3명"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let MatchCellDetailsTags:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("   #자료구조이해  ", for: .normal)
        button.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14,weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let MatchCellDetailsText:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "소개"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let MatchCellDetailsTextField:UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = UIColor(r: 224, g: 224, b: 224)
//        label.text = "송하윤 교수님 자료구조 '과제11_지하철'같이 해결할 분들 찾아요.. 감자를 살려주십숑.."
//        label.layer.opacity = 0.2
        label.layer.cornerRadius = 10
        return label
    }()
    
    let reply:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "댓글"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let replypost:UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.spacing = 10
        stackview.distribution = .equalSpacing
        return stackview
    }()
    
    let replytext:UITextView = {
        let textview = UITextView()
        textview.backgroundColor = UIColor(r: 224, g: 224, b: 224)
        textview.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.layer.cornerRadius = 3
        return textview
        }()
    
    let replybutton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("등록", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14,weight: .bold)
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(MatchCellDetailsReplyButton), for: .allEvents)
        return button
        
    }()
    
    @objc func MatchCellDetailsReplyButton(_ sender:Any){
        if self.replytext.text.isEmpty {
            let alert_done = UIAlertController(
                title: "댓글 내용을 입력해주세요.",
                message: nil,
                preferredStyle: .alert)
            alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))

            self.present(alert_done, animated: true)
            
            return
            
        }
            
            let alert = UIAlertController(
                title: "댓글을 등록하시겠습니까?",
                message: nil,
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "등록", style: .default, handler: { action in
                //업로드 통신
                let commentByUser = CommentRegister(commentContext: self.replytext.text!)
                
                PostManager.shared.registerComment(ID: self.id, comment: commentByUser) { result in
                    switch result {
                    case .success(let success):
                        print(success)
                        let alert_done = UIAlertController(
                            title: "등록 완료",
                            message: nil,
                            preferredStyle: .alert)
                        alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))

                        self.present(alert_done, animated: true)

                        self.replytext.text = ""
                        self.showMatchDetails()
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }))
            
            
            
            self.present(alert, animated: true)
        }
    
    let chatpost:UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("채팅 걸기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18,weight: .bold)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(testfunc), for: .allEvents) // 테스트용 댓글 밀기
        return button
    }()
    //테스트용 댓글 밀기
    @objc func testfunc(_ sender:Any){
        self.comments.removeAll()
        self.tableview.reloadData()
    }
    
    let MatchCellDetailsCategory : UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .leading
        stackview.spacing = 10
        return stackview
    }()
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "댓글"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let tableViewData = [
        ["1","2","3","4","5"],
        ["1","2","3","4","5"],
        ["1","2","3","4","5"],
        ["1","2","3","4","5"],
        ["1","2","3","4","5"],
    ]
    
    var hiddenSections = Set<Int>()
    
    
    
    

//    let MatchCellDetailsCategoryStackView = AloeStackView()
//
//    let CategoryButton = SelectedCategoryButton()
//
//    func MatchCellDetailsCategory(){
//        let CategoryButton = SelectedCategoryButton()
//        CategoryButton.translatesAutoresizingMaskIntoConstraints = false
//        MatchCellDetailsCategoryStackView.addRow(CategoryButton)
//    }
//
    
    let tableview = UITableView(frame: .zero, style: .grouped)
    @objc private func backButtonPressed(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
        }
    
    let collectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
    
    let flowLayout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal
       layout.minimumLineSpacing = 4.0
//       layout.minimumInteritemSpacing = 0
       return layout
     }()
    
    func showMatchDetails() {
        // MARK: - Network
        PostManager.shared.getPost(ID: id) { result in
            switch result {
                     case .success(let success):
                        self.MatchCellDetailsTitle.text = success.data1.postTitle
                        self.MatchCellDetailsDate.text = success.data1.createdDate
                        self.MatchCellDetailsTags.setTitle(success.data1.postTag1, for: .normal)
//                self.MatchCellDetailsViewCount.text = success.data1. //조회수 포기?
//                self.MatchCellDetailsNumber.text = success.data1.postMember //서버에서 넘겨준거에서 누락됨
                        self.MatchCellDetailsTextField.text = success.data1.postContext
                //댓글
                        self.comments.removeAll()
                print(self.comments)
                        for comment in success.data2 {
                            self.comments.append(Comment.init(commentId: comment.commentId,
                                                              commentContext: comment.commentContext,
                                                              likeNumber: comment.likeNumber,
                                                              createdDate: comment.createdDate,
                                                              commentReplyDtoList: comment.commentReplyDtoList))
                        }
                print(self.comments)
                self.tableview.reloadData()
                     case .failure(let failure):
                         print(failure)
                     }
                 }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showMatchDetails()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(MatchCellDetailsTitle)
        self.view.addSubview(UnderLine)
        self.view.addSubview(MatchCellDetailsTags)
        
        self.view.addSubview(UnderLine1)
        self.view.addSubview(MatchCellDetailsAddButton)
        self.view.addSubview(container)
        self.container.addArrangedSubview(MatchCellDetailsDate)
        self.container.addArrangedSubview(MatchCellDetailslike)
        self.container.addArrangedSubview(MatchCellDetailsViewCount)
        self.view.addSubview(MatchCellDetailsCategory)
//        self.MatchCellDetailsCategory.addArrangedSubview(CategoryButton2)
        self.view.addSubview(MatchCellDetailsNumber)
        self.view.addSubview(MatchCellDetailsText)
        self.view.addSubview(MatchCellDetailsTextField)
        self.view.addSubview(reply)
        self.view.addSubview(tableview)
        self.view.addSubview(chatpost)
        self.view.addSubview(replypost)
        self.replypost.addArrangedSubview(replytext)
        self.replypost.addArrangedSubview(replybutton)
        
        self.tableview.translatesAutoresizingMaskIntoConstraints = false
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(DetailReplyCell.self, forCellReuseIdentifier: "DetailReplyCell")
        self.tableview.reloadData()
        self.tableview.separatorStyle = .none
        self.tableview.layoutIfNeeded()
        self.tableview.rowHeight = 70
        self.tableview.backgroundColor = .white
        
        self.view.addSubview(collectionview)
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        self.collectionview.register(listCell.self, forCellWithReuseIdentifier: "listCell")
        self.collectionview.translatesAutoresizingMaskIntoConstraints = false
        self.collectionview.reloadData()
        self.collectionview.collectionViewLayout = flowLayout
        
        self.collectionview.addSubview(header)
        self.view.addSubview(MatchCellDetailslikeCount)

        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(imageLiteralResourceName:"ic 1"), style: .plain, target:self , action: #selector(backButtonPressed))
        NSLayoutConstraint.activate([
            self.MatchCellDetailsTitle.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 108),
            self.MatchCellDetailsTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            self.MatchCellDetailsAddButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.MatchCellDetailsAddButton.widthAnchor.constraint(equalToConstant: 24),
            self.MatchCellDetailsAddButton.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 108),
            self.MatchCellDetailsCategory.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.MatchCellDetailsCategory.topAnchor.constraint(equalTo: self.container.bottomAnchor,constant: 10),
            self.container.widthAnchor.constraint(equalToConstant: 300),
            self.container.heightAnchor.constraint(equalToConstant: 14),
            self.container.topAnchor.constraint(equalTo: self.MatchCellDetailsTitle.bottomAnchor, constant: 15),
            self.container.leadingAnchor.constraint(equalTo: self.MatchCellDetailsTitle.leadingAnchor ),
            
            self.MatchCellDetailslikeCount.topAnchor.constraint(equalTo: self.MatchCellDetailsTitle.bottomAnchor, constant: 15),
            self.MatchCellDetailslikeCount.leadingAnchor.constraint(equalTo: self.MatchCellDetailsTitle.leadingAnchor,constant: 200 ),

            self.MatchCellDetailsNumber.topAnchor.constraint(equalTo: self.MatchCellDetailsCategory.bottomAnchor, constant: 10),
            self.MatchCellDetailsNumber.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
        
            self.UnderLine.heightAnchor.constraint(equalToConstant: 1),
            self.UnderLine.topAnchor.constraint(equalTo: self.MatchCellDetailsNumber.bottomAnchor,constant: 10),
            self.UnderLine.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.UnderLine.trailingAnchor.constraint(equalTo: self.MatchCellDetailsTextField.trailingAnchor),
            
            self.MatchCellDetailsTags.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.MatchCellDetailsTags.topAnchor.constraint(equalTo: self.UnderLine.bottomAnchor, constant: 10),
            
            self.UnderLine1.heightAnchor.constraint(equalToConstant: 1),
            self.UnderLine1.topAnchor.constraint(equalTo: self.MatchCellDetailsTags.bottomAnchor,constant: 10),
            self.UnderLine1.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.UnderLine1.trailingAnchor.constraint(equalTo: self.MatchCellDetailsTextField.trailingAnchor),
            
            self.MatchCellDetailsText.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.MatchCellDetailsText.topAnchor.constraint(equalTo: self.MatchCellDetailsTags.bottomAnchor, constant: 20),
            

            self.MatchCellDetailsTextField.leadingAnchor.constraint(equalTo: self.MatchCellDetailsTitle.leadingAnchor),
            self.MatchCellDetailsTextField.topAnchor.constraint(equalTo: self.MatchCellDetailsText.topAnchor, constant: 24),
            self.MatchCellDetailsTextField.heightAnchor.constraint(equalToConstant: 115),
            self.MatchCellDetailsTextField.widthAnchor.constraint(equalToConstant: 361),
            self.tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 590),
//            self.tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -170),
            self.tableview.heightAnchor.constraint(equalToConstant: 135),
            self.tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            self.tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            self.reply.topAnchor.constraint(equalTo: self.tableview.topAnchor,constant:  -24),
            self.reply.leadingAnchor.constraint(equalTo: self.tableview.leadingAnchor),
            
            self.chatpost.bottomAnchor.constraint(equalTo: self.tableview.bottomAnchor, constant: 40),
            self.chatpost.leadingAnchor.constraint(equalTo: self.tableview.leadingAnchor),
            self.chatpost.widthAnchor.constraint(equalToConstant: 380),
            self.chatpost.heightAnchor.constraint(equalToConstant: 35),
            self.replypost.leadingAnchor.constraint(equalTo: self.tableview.leadingAnchor),
            self.replypost.trailingAnchor.constraint(equalTo: self.chatpost.trailingAnchor),
            self.replypost.topAnchor.constraint(equalTo: self.chatpost.bottomAnchor,constant: 4),
            
            self.replytext.widthAnchor.constraint(equalToConstant: 342),
            self.replytext.heightAnchor.constraint(equalTo: self.replybutton.heightAnchor),
            
            
            self.collectionview.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.collectionview.trailingAnchor.constraint(equalTo: self.UnderLine.trailingAnchor),
            self.collectionview.topAnchor.constraint(equalTo: self.UnderLine.bottomAnchor, constant: 10),
            self.collectionview.heightAnchor.constraint(equalToConstant: 32),
//            self.CategoryButton.heightAnchor.constraint(equalToConstant: 32),
//            self.CategoryButton.widthAnchor.constraint(equalToConstant: 96),
           
            
            


        ])
        
    
        
    }


}





extension MatchCellDetailsVC:UITableViewDataSource,UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailReplyCell") as! DetailReplyCell
        cell.backgroundColor = .white
        cell.usertext.text = comments[indexPath.row].commentContext
        cell.datetext.text = comments[indexPath.row].createdDate
        cell.detailreplyreactionVC.heartButtonCount.text = String(comments[indexPath.row].likeNumber)
        cell.detailreplyreactionVC.likeButtonCount.text = String(comments[indexPath.row].likeNumber)
        cell.userid.text = String(comments[indexPath.row].commentId)

        
        
        //        cell.heartButtonCount.text = comments[indexPath.row] //대신에 댓글 수?
        return cell
    }
   
}
    
    extension MatchCellDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let tmpLabel : UILabel = UILabel()
            tmpLabel.text = tagList[indexPath.item]
            return CGSize(width: tmpLabel.intrinsicContentSize.width, height: 28)
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return tagList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! listCell
            cell.memberNameLabel.text = tagList[indexPath.row]
            return cell
        }
        
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
    }
