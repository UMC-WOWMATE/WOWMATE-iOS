//
//  MatichDetails.swift
//  HomeVC_EX
//
//  Created by Dongwan Ryoo on 2023/01/18.
//

import Foundation
import UIKit

class MatchDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailReplyCell") as! DetailReplyCell
        cell.backgroundColor = .blue
        return cell
    }
    
    
    private let tableview = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.view.addSubview(self.tableview)
        self.tableview.separatorStyle = .singleLine
        self.tableview.translatesAutoresizingMaskIntoConstraints = false
        self.tableview.register(DetailReplyCell.self, forCellReuseIdentifier: "DetailReplyCell")
        NSLayoutConstraint.activate([
            self.tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    
        ])
        
    }

}

    


