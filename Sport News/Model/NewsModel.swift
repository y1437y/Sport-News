//
//  NewsModel.swift
//  Sport News
//
//  Created by Hayden Kaci on 10/2/18.
//  Copyright © 2018 Chien. All rights reserved.
//

import Foundation
import Alamofire

class News: Codable {
    var status: String
    var totalResults: Int
    var articles: [articles]
    
    init(status: String, totalResults: Int, articles: [articles]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

class articles: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var source: source?
    
    init(author: String, title: String, description: String, url: String, urlToImage: String, publishedAt: String, source: source) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.source = source
    }
}

class source: Codable {
    var id: String?
    var name: String?
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

class NewsModel {
    
    var NewsTitle = [String]()
    var NewsSource = [String]()
    var NewsURL = [String]()
    var NewsPublishedDate = [String]()
    
    func getNews(team: String, completion: ( () -> Void)?) {
        let urlString = "https://newsapi.org/v2/everything?q=\(team)&sources=fox-sports&sortBy=publishedAt&apiKey=84c04d50273c41129d79a4fc8704d198"
        Alamofire.request(urlString).responseJSON { (response) in
            guard let jsonDic = response.data else { return }
            do {
                let jsonDecode = try JSONDecoder().decode(News.self, from: jsonDic)
                jsonDecode.articles.forEach({ (article) in
                    self.NewsTitle.append(article.title!)
                    self.NewsSource.append((article.source?.name)!)
                    self.NewsURL.append(article.url!)
                    let df = DateFormatter()
                    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                    guard let date = df.date(from: article.publishedAt!) else { return }
                    let newdf = DateFormatter()
                    newdf.dateFormat = "MMM dd, yyyy"
                    let newDate = newdf.string(from: date)
                    self.NewsPublishedDate.append(newDate)
                })
            } catch let error as NSError {
                print("Error happens with \(error.localizedDescription)")
            }
            print(urlString)
            completion!()
        }
    }

}
