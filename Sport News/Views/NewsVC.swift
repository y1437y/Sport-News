//
//  NewsVC.swift
//  Sport News
//
//  Created by Hayden Kaci on 10/2/18.
//  Copyright © 2018 Chien. All rights reserved.
//

import UIKit
import Alamofire

class NewsVC: UIViewController {

    let model = NewsModel()
    var pageTitle: String?
    @IBOutlet weak var NewsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = pageTitle
        let newTeam = pageTitle?.replacingOccurrences(of: " ", with: "%20")
        DispatchQueue.global().async {
            let lock = DispatchSemaphore(value: 0)
            self.model.getNews(team: newTeam!, completion: {
                lock.signal()
                self.NewsTable.reloadData()
            })
            lock.wait()
        }
    }
}

extension NewsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.NewsTitle.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "news") as? NewsCells else { return UITableViewCell() }
        cell.Title.text = model.NewsTitle[indexPath.item] + "\n\n"
        cell.Date.text = model.NewsPublishedDate[indexPath.item]
        return cell
    }
}
