//
//  SearchVC.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/08.
//

import UIKit
import SwiftUI

class SearchVC: UIViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recentSearchTableView: UITableView!
    
    private var inputSearchKeyword: String = ""
    private var recentSearchKeywordList: [String] = [] // UserDefaults 사용하여 저장/조회/삭제 구현 예정
    
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpLayout()
        retrieveSearchKeywordList()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    @IBAction func didTapBackwardButton(_ sender: Any) {
        print("뒤로가기 버튼 클릭됨")
    }
    
    @IBAction func didTapAllClearButton(_ sender: UIButton) {
        recentSearchKeywordList = []
        UserDefaults.standard.removeObject(forKey: "recentSearchKeywordList")
        recentSearchTableView.reloadData()
    }
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    private func setUp() {
        searchBar.delegate = self
        recentSearchTableView.delegate = self
        recentSearchTableView.dataSource = self
    }
    
    private func setUpLayout() {
        searchBar.text = ""
        searchBar.placeholder = "검색어를 입력해주세요"
        
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        recentSearchTableView.separatorStyle = .none
    }
    
    private func showResultViewController(_ input: String?) {
        guard let resultVC = storyboard?.instantiateViewController(withIdentifier: "SearchResultVC") as? SearchResultVC else { return }
        resultVC.delegate = self
        resultVC.inputSearchKeyword = input
        
        resultVC.modalPresentationStyle = .fullScreen
        present(resultVC, animated: true)
    }
    
    // 입력 검색어 조회, 저장, 삭제
    private func retrieveSearchKeywordList() {
        recentSearchKeywordList = UserDefaults.standard.stringArray(forKey: "recentSearchKeywordList") ?? [String]()
        recentSearchTableView.reloadData()
    }
    
    private func saveSearchInput(_ inputKeyword: String) {
        if inputKeyword.count > 0 {
            recentSearchKeywordList.append(inputKeyword)
            UserDefaults.standard.set(recentSearchKeywordList, forKey: "recentSearchKeywordList")
        }
    }
    
    func deleteSearchKeyword(_ index: Int) {
        recentSearchKeywordList.remove(at: index)
        UserDefaults.standard.removeObject(forKey: "recentSearchKeywordList")
        UserDefaults.standard.set(recentSearchKeywordList, forKey: "recentSearchKeywordList")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}


extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchKeywordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if recentSearchKeywordList.count == 0 { return UITableViewCell() }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchTableViewCell", for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.keywordLabel.text = recentSearchKeywordList[indexPath.row]
            return cell
        }
    }
    
    
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showResultViewController(recentSearchKeywordList[indexPath.row])
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let input = searchBar.text {
            if input.count == 0 {
                let alert = UIAlertController(title: "입력 없음", message: "검색어를 입력해주세요", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                present(alert, animated: true)
            } else {
                saveSearchKeyword(input)
                showResultViewController(recentSearchKeywordList.last)
            }
        }
    }
    
    func dismissKeyboard() { searchBar.resignFirstResponder() }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.placeholder = ""
        return true
    }
}

extension SearchVC: RecentSearchDelegate {
    func saveSearchKeyword(_ inputKeyword: String) { saveSearchInput(inputKeyword) }
    
    func deleteSelectedKeyword(_ selected: RecentSearchTableViewCell) {
        let index = recentSearchTableView.indexPath(for: selected)!
        deleteSearchKeyword(index.row)
        recentSearchTableView.reloadData()
    }
}
