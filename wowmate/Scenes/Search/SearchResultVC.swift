//
//  SearchResultVC.swift
//  wowmate
//
//  Created by 김초원 on 2023/01/19.
//

import UIKit

class SearchResultVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
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
        setUp()
        setUpLayout()
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
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    private func setUp(){
        searchBar.delegate = self
        let resultCell = UINib(nibName: "MatchInfoPreviewTableViewCell", bundle: nil)
        matchResultTableView.register(resultCell, forCellReuseIdentifier: "MatchInfoPreviewTableViewCell")
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchInfoPreviewTableViewCell", for: indexPath) as? MatchInfoPreviewTableViewCell else { return UITableViewCell() }
        cell.title.text = "\(inputSearchKeyword ?? "") 어쩌고 매칭 \(indexPath.row)"  // test title
        cell.setUpLayout()
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135  // default height value
    }
}

extension SearchResultVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("매칭 결과 \(indexPath.row) 가 선택됨")
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
