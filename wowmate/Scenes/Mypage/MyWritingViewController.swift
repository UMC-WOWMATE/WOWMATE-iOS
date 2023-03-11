 //
//  MyWritingViewController.swift
//  wowmate
//
//  Created by 장윤정 on 2023/01/19.
//

import UIKit

class MyWritingViewController: UITableViewController {
    
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    let Sections = ["",""]
    
    var posts: [PostData1] = []
//
    let CategoryBox: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.backgroundColor = .orange
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()

//    func
    
    func showMyPosts() {
        PostManager.shared.getMyPostList { result in
            switch result {
                     case .success(let success):
                print(success)
                self.posts.removeAll()
                for post in success.data1 {
                    self.posts.append(PostData1.init(postId: post.postId,
                                                     postTitle: post.postTitle,
                                                     categoryName: post.categoryName,
                                                     tag1: post.tag1, tag2: post.tag2,
                                                     tag3: post.tag3, tag4: post.tag4, tag5: post.tag5,
                                                     postLikeNumber: post.postLikeNumber,
                                                     postMember: post.postMember,
                                                     image_url: post.image_url ?? "",
                                                     createdDate: post.createdDate))
//                    matchlogo = ["건국대","다운로드 1","한국체대","홍대교표_블루","홍대교표_블루","건국대",]
                }
                self.tableView.reloadData()
                     case .failure(let failure):
                         print(failure)
                     }
                 }
    }
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    // MARK: - Network
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showMyPosts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.view.addSubview(CategoryBox)
//        self.CategoryBox.addArrangedSubview(CategoryButton)
//
//        NSLayoutConstraint.activate([
//            self.CategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
//            self.CategoryButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 200),
//            self.CategoryButton.heightAnchor.constraint(equalToConstant: 32),
//            self.CategoryButton.widthAnchor.constraint(equalToConstant: 96),
//
//        ]
        
        configure()
        navigation()
    }
    

    
    // MARK: - HELPERS
    func configure(){
        view.backgroundColor = .white
        tableView.rowHeight = 135
        tableView.separatorStyle = .none
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        tableView.tableHeaderView = nil
        tableView.reloadData()
        

    }
    
    func navigation(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(imageLiteralResourceName:"off 3"), style: .plain, target:self , action: nil)
    }
    
    //MARK: - UIVivewControllerViewDataSourece
        
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        20
//
//    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
                let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell; return cell
                
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell;
        
        func getDate(_ date:String) -> String {
            return String(date.prefix(10))
        }
        
//        cell.ID = posts[indexPath.row].postId
        cell.MainCellName.text = posts[indexPath.row].postTitle
        cell.MainCellCategory.text = posts[indexPath.row].categoryName
        cell.MainCellTag.text = "#" + (posts[indexPath.row].tag1 ?? "")
        cell.MainCellDate.text = getDate(posts[indexPath.row].createdDate)
        cell.MainCellLikeCount.text = String(posts[indexPath.row].postLikeNumber)
//        cell.MainCellImage.image(<#T##t: String##String#>) //posts[indexPath.row].schoolName string으로 적절히 삽입
        
        
        return cell
        }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension : 135
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let matchdetails = MatchCellDetailsVC_AloeStackView()
        matchdetails.PostID = posts[indexPath.row].postId
        matchdetails.Img = posts[indexPath.row].image_url ?? ""
        self.navigationController?.pushViewController(matchdetails, animated: true)
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
//            let headerView = UIView()
//            CategoryButton.setTitle("hihi", for: .normal)
//            headerView.addSubview(CategoryButton)
//            return headerView
//        }
    override func numberOfSections(in tableView: UITableView) -> Int {
            return Sections.count
        }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return Sections[section]
       }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if(section == 0)
            {
                return 1
            }
        return posts.count
        
        }
}
    





