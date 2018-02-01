//
//  NewsViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 1/2/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class NewsViewController: UITableViewController {

    @IBOutlet var newsTable: UITableView!
    
    var newsArray = [NewsDataTemplate]()
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        newsTable.delegate = self
        newsTable.dataSource = self
        //hide separator for empty cell
        newsTable.tableFooterView = UIView()
        
        let newsUrl = "https://newsapi.org/v2/top-headlines"
        let apiKey = "9d4c925408fb461ca65c2de49762c1c4"
        let params : [String : String] = ["apiKey" : apiKey, "country" : "us"]
        
        getNewsData(url: newsUrl, parameters: params)
        
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue Resuable Cell
        let cell = newsTable.dequeueReusableCell(withIdentifier: "NewsCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "NewsCell")
        
        cell.textLabel?.text = newsArray[indexPath.row].title
        cell.detailTextLabel?.text = newsArray[indexPath.row].description
        cell.imageView?.image = UIImage(named: "News")
        
        return cell
    }
    
    //MARK: - Netwroking
    /*********************************************************/
    
    func getNewsData(url: String, parameters: [String : String]) {
        //Progress message
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.show(withStatus: "Fetching latest headlines")
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                let newsJSON : JSON  = JSON(response.result.value!)
                
                self.updateNews(json: newsJSON)
            }
            else {
                print("Error from api: \(String(describing: response.result.value))")
            }
        }
    }
    
    
    //MARK: - JSON Parsing
    /*********************************************************/
    
    func updateNews(json: JSON) {
        
        for i in 0..<20 {
        
            if let title = json["articles"][i]["title"].string {
                let news = NewsDataTemplate()
            
                news.title = title
                
                //Check for nulls from api
                
                if let source = json["articles"][i]["source"]["name"].string {
                    news.source = source
                }
                
                if let author = json["articles"][i]["author"].string {
                    news.author = author
                }
                if let description = json["articles"][i]["description"].string {
                    news.description = description
                }
                if let imageUrl = json["articles"][i]["urlToImage"].string {
                    news.imageUrl = imageUrl
                }
                if let publishedAt = json["articles"][i]["publishedAt"].string {
                    news.publishedAt = publishedAt
                }

                if let url = json["articles"][i]["url"].string {
                    news.url = url
                }
                
                newsArray.append(news)
            }
            else {
                print("Fetch failed")
            }
            newsTable.reloadData()
            //Dismiss progress message
            SVProgressHUD.dismiss()
        }
     
    }
}
