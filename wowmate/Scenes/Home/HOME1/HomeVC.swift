import UIKit

class HomeVC: UITableViewController {
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
    
    func showAllPosts() {
        PostManager.shared.getPostList { result in
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
                                                     schoolName: post.schoolName,
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
        showAllPosts()
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
        
        let schoolname:String = posts[indexPath.row].schoolName
        
//        switch schoolname {
//        case "홍익대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "홍익")
//        case "서울대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "서울대")
//        case "연세대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "연세대")
//        case "고려대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "고려대")
//        case "성균관대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "성대")
//        case "한양대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "한양대")
//        case "서강대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "서강대")
//        case "중앙대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "중앙")
//        case "경희대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "경희")
//        case "한국외대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "한국외")
//        case "시립대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "서울시립")
//        case "숙명여대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "숙명여")
//        case "명지대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "명지")
//        case "가천대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "가천")
//        case "가톨릭대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "가톨릭")
//        case "광운대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "광운")
//        case "단국대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "단국")
//        case "덕성여대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "덕성여")
//        case "동국대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "동국")
//        case "동덕여대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "동덕여")
//        case "부경대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "부경")
//        case "부산대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "부산")
//        case "서울여대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "서울여")
//        case "성신여대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "성신여")
//        case "세종대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "세종")
//        case "숭실대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "숭실")
//        case "아주대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "아주")
//        case "이화여대"
//            :cell.MainCellImage.image =
//            UIImage(imageLiteralResourceName: "이화여")
//
//        case "인하대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "인하")
//        case "항공대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "한국항공")
//        case "한양대"
//            :cell.MainCellImage.image = UIImage(imageLiteralResourceName: "한양")
//
//        default:
//            cell.MainCellImage.image = UIImage(imageLiteralResourceName: "홍익")
//        }
        
        return cell
        }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension : 135
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let matchdetails = MatchCellDetailsVC_AloeStackView()
        matchdetails.PostID = posts[indexPath.row].postId
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
    





