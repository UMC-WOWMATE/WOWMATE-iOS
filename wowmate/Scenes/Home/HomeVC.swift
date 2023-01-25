import UIKit

class HomeVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configireViewControllers()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(imageLiteralResourceName:"off 3"), style: .plain, target:self , action: nil)
    }
    
    
    // MARK: - HELPERS
    func configireViewControllers(){
        view.backgroundColor = .white
    
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.reloadData()
    }
    
    //MARK: - UIVivewControllerViewDataSourece
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell; return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let matchdetails = MatchCellDetailsVC()
        self.navigationController?.pushViewController(matchdetails, animated: true)
    }
    


}
