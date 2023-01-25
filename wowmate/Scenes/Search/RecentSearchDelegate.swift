//
//  RecentSearchDelegate.swift
//  
//
//  Created by 김초원 on 2023/01/21.
//

import Foundation

protocol RecentSearchDelegate: AnyObject {
    func saveSearchKeyword(_ inputKeyword: String)
    func deleteSelectedKeyword(_ selected: RecentSearchTableViewCell)
}
