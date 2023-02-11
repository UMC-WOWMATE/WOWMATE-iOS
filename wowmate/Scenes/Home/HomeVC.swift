import UIKit

class HomeVC: UITableViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    let Sections = ["",""]
    
//    var matchtitlelist = ["자료구조 이해 팀플 구함","잔나비 콘서트 갈 사람!","운동파트너 구합니다","홍개팅","[패디]졸업전시 모델 구합니다","16일 중대부고 풋살 1명"]
//    var matchcategorylist = ["수업","취미","운동","연애","수업","취미"]
//    var matchtags = ["#자료구조이해","#잔나비#콘서트","#운동#3대100","#연애#ENFP#홍익대","#패디,#CLEINE#DIOR","#한반두#우리형",]
//    var matchdate = ["2023.01.21","2023.01.21","2023.01.21","2023.01.21","2023.01.21","2023.01.21",]
//    var matchlikecount = ["10","32","22","100","23","24",]
//    var matchlogo = ["건국대","다운로드 1","한국체대","홍대교표_블루","홍대교표_블루","건국대",]
    var matchtitlelist: [String] = []
    var matchcategorylist: [String] = []
    var matchtags: [String] = []
    var matchdate: [String] = []
    var matchlikecount: [String] = []
    var matchlogo: [String] = []
//
    let CategoryBox: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.backgroundColor = .orange
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()

    
                        
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PostManager.shared.getPostList { result in
            switch result {
                     case .success(let success):
                for post in success.data1 {
                    self.matchtitlelist.append(post.postTitle)
                    self.matchcategorylist.append(post.categoryName)
                    self.matchtags.append(post.tag1)
                    self.matchdate.append(post.createdDate)
                    self.matchlikecount.append(String(post.postLikeNumber))
//                    matchlogo = ["건국대","다운로드 1","한국체대","홍대교표_블루","홍대교표_블루","건국대",]
                }
                self.tableView.reloadData()
                     case .failure(let failure):
                         print(failure)
                     }
                 }
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
        cell.MainCellName.text = matchtitlelist[indexPath.row]
        cell.MainCellCategory.text = matchcategorylist[indexPath.row]
        cell.MainCellTag.text = matchtags[indexPath.row]
        cell.MainCellDate.text = matchdate[indexPath.row]
        cell.MainCellLikeCount.text = matchlikecount[indexPath.row]
//        cell.MainCellImage.image = UIImage(named: matchlogo[indexPath.row])
        
        return cell
        }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension : 135
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let matchdetails = MatchCellDetailsVC()
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
        return matchtitlelist.count
        
        }
    }
    





