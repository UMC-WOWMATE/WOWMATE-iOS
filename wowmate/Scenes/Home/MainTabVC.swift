
import Foundation
import UIKit

class MainTabVC: UITabBarController {

    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        configireViewControllers()
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    func configireViewControllers(){
        view.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        let Home = templateNavigationController(unuselectingIamge: #imageLiteral(resourceName: "off 4"), rootViewController: HomeVC())
        let Match = templateNavigationController(unuselectingIamge: #imageLiteral(resourceName: "off"), rootViewController: MatchVC())
        let Search = templateNavigationController(unuselectingIamge: #imageLiteral(resourceName: "off 5"), rootViewController: SearchVC())
        let ChatList = templateNavigationController(unuselectingIamge: #imageLiteral(resourceName: "off 2"), rootViewController: ChatListVC())
        let Mypage = templateNavigationController(unuselectingIamge: #imageLiteral(resourceName: "off 1"), rootViewController: MypageVC())
        viewControllers = [Home,Search, Match, ChatList, Mypage]
    
        
    }
    
    func templateNavigationController(unuselectingIamge: UIImage, rootViewController:UIViewController) -> UINavigationController{
            let nav = UINavigationController(rootViewController: rootViewController)
            nav.tabBarItem.image = unuselectingIamge
            nav.navigationBar.tintColor = .black
            return nav
        }
    

}




    
    



