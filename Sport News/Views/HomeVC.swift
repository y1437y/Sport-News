import UIKit

class HomeVC: UIViewController {

    let model = NewsModel()
    let Teams = ["LA Lakers", "St. Louis Cardinals", "New York Yankees", "Chicago Cubs", "Chicago Bulls"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "teams") as? TeamCells else { return UITableViewCell() }
        cell.Teams.text = Teams[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = self.storyboard?.instantiateViewController(withIdentifier: "NewsVC") as! NewsVC
        news.pageTitle = Teams[indexPath.row]
        navigationController?.pushViewController(news, animated: true)
    }
}

