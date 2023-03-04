//
//  NotificationVC.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/08.
//

import UIKit
import Tabman
import Pageboy

class NotificationVC: TabmanViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
//    let ViewControllers = [UIViewController(), UIViewController()]
    let ViewControllers = [PostNotificationVC(), ChatNotificationVC()]

    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationbarView()
        setUpTabmanVC()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    @IBAction func closeButtonDidTab(_ sender: UIBarButtonItem) {
        print("closed")
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    func setUpNavigationbarView() {
        navigationController?.navigationBar.backgroundColor = .white
        
        let closeButton = UIBarButtonItem(image: UIImage(named: "ic 1"), style: .plain, target: self, action: #selector(closeButtonDidTab(_:)))
        closeButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = closeButton
    }
    
    func setUpTabmanVC() {
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.setHeight(height: 43)
        
        bar.buttons.customize { (button) in
            button.tintColor = UIColor(r: 130, g: 130, b: 130)
            button.selectedTintColor = UIColor(r: 101, g: 81, b: 224)
        }

        self.addBar(bar, dataSource: self, at: .top)
    }
}

extension NotificationVC: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return ViewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        ViewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        let title = "Page \(index)"
        return TMBarItem(title: title)
    }
    
    
}
