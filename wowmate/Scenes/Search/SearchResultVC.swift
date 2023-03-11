//
//  SearchResultVC.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/19.
//

import UIKit
import Kingfisher

class SearchResultVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    var resultMatchList: [Match] = []
    var inputSearchKeyword: String? = nil
    weak var delegate: RecentSearchDelegate?
        
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var matchResultTableView: UITableView!
    
    @IBOutlet weak var refCategory1Button: UIButton!
    @IBOutlet weak var refCategory2Button: UIButton!
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(keyword: inputSearchKeyword)
        setUp()
        setUpLayout()
    }
    
    private func fetchData(keyword: String?) {
        if let keyword = keyword {
            SearchManager.shared.searchPostRequest(keyword: keyword) { [weak self] result in
                switch result {
                case .success(let success):
                    if success.code == 200 {

                        self?.resultMatchList = success.data1!
//                        print("resultMatchList :: \(self?.resultMatchList)")
                        self?.matchResultTableView.reloadData()
                        self?.setRefCategoryButtons()
                        
                    } else if success.code == 300 {
                        print("검색 결과 없음")
                        self?.showAlert()
                        self?.navigationController?.popToRootViewController(animated: true) // 웨않뒈;
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: nil, message: "검색 결과가 없습니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    private func setRefCategoryButtons() {
        if resultMatchList.count > 0 {
            let title1 = resultMatchList[0].tag1
            let title2 = resultMatchList[0].tag2
            refCategory1Button.setTitle(title1, for: .normal)
            refCategory2Button.setTitle(title2, for: .normal)
            
            [
                refCategory1Button,
                refCategory2Button
                
            ].forEach { $0.isHidden = false }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let inputSearchKeyword = inputSearchKeyword {
            searchBar.placeholder = inputSearchKeyword
        }
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    private func setUp(){
        navigationController?.navigationBar.isHidden = true
        searchBar.delegate = self
        
        if resultMatchList.count == 0 {
            [
                refCategory1Button,
                refCategory2Button
                
            ].forEach { $0.isHidden = true }
        }
        
//        let resultCell = UINib(nibName: "MatchInfoPreviewTableViewCell", bundle: nil)
//        matchResultTableView.register(resultCell, forCellReuseIdentifier: "MatchInfoPreviewTableViewCell")
//        let resultCell = UINib(nibName: "MainCell", bundle: nil)
        matchResultTableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
    }
    
    private func setUpLayout() {
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        matchResultTableView.separatorStyle = .none
        
        [
            refCategory1Button,
            refCategory2Button
            
        ].forEach {
            $0?.backgroundColor = .systemBackground
            
            $0?.layer.borderWidth = 0.5
            $0?.layer.borderColor = UIColor.lightGray.cgColor
            $0?.layer.cornerRadius = 15
            
            $0?.layer.shadowColor = UIColor.lightGray.cgColor
            $0?.layer.shadowOpacity = 0.5
            $0?.layer.shadowOffset = .zero
            $0?.layer.shadowRadius = 5
        }
    }
    
    private func showResultViewController(_ input: String?) {
        delegate?.saveSearchKeyword(input ?? "")
        
        guard let resultVC = storyboard?.instantiateViewController(withIdentifier: "SearchResultVC") as? SearchResultVC else { return }
        resultVC.modalPresentationStyle = .fullScreen
        resultVC.inputSearchKeyword = input ?? "검색어를 입력해주세요"

        present(resultVC, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension SearchResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultMatchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let postInfo = resultMatchList[indexPath.row]
//        cell.configure(postInfo: postInfo)
        
        schoolImgUrl.keys.forEach {
            if $0 == (postInfo.schoolName+"학교") {
                cell.MainCellImage.kf.setImage(with: URL(string: schoolImgUrl[$0]!))
            }
        }

        cell.ID = postInfo.postId
        cell.MainCellName.text = postInfo.postTitle
        cell.MainCellCategory.text = postInfo.categoryName
        cell.MainCellDate.text = postInfo.createdDate   // TODO: "0000-00-00 형태로 문자열 자르기"
        cell.MainCellLikeCount.text = String(postInfo.postLikeNumber)
        cell.MainCellTag.text = postInfo.tag1
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140  // default height value
    }
}

extension SearchResultVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellDetailVC = MatchCellDetailsVC_AloeStackView()
        let postInfo = resultMatchList[indexPath.row]
        cellDetailVC.PostID = postInfo.postId
        navigationController?.pushViewController(cellDetailVC, animated: true)
    }
}

extension SearchResultVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let input = searchBar.text {
            if input.count == 0 {
                let alert = UIAlertController(title: "입력 없음", message: "검색어를 입력해주세요", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                present(alert, animated: true)
            } else {
                showResultViewController(searchBar.text)
            }
        }
    }

}
