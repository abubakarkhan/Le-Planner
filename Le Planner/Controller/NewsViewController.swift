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
import SwiftySound
import SVProgressHUD

class NewsViewController: UITableViewController {

    //News api details
    private let newsUrl = "https://newsapi.org/v2/top-headlines"
    private let apiKey = "9d4c925408fb461ca65c2de49762c1c4"
    private var country =  "us"
    
    @IBOutlet var newsTable: UITableView!
    
    private var newsArray = [NewsDataTemplate]()
    private var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    private var refresher : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        newsTable.delegate = self
        newsTable.dataSource = self
        //hide separator for empty cell
        newsTable.tableFooterView = UIView()
        
        //Pull to refresh setup
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(HomeViewController.refreshData), for: UIControlEvents.valueChanged)
        newsTable.addSubview(refresher)
        
        getNewsData(url: newsUrl)
        
    }
    //MARK - Pull to refresh
    @objc func refreshData(){
        getNewsData(url: newsUrl)
        refresher.endRefreshing()
        Sound.play(file: "refreshSound.wav")
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
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedNews = newsArray[indexPath.row]
        
        self.performSegue(withIdentifier: "NewsToDetail", sender: selectedNews)
        
        Sound.play(file: "tapSound.wav")
    }
    
    //Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsToDetail" {
            let destinationVC = segue.destination as! NewsDetailViewController
            destinationVC.newsDetail = sender as? NewsDataTemplate
        }
    }
    
    //Serach with new paramteres
    @IBAction func updateSearch(_ sender: UIBarButtonItem) {
        
        Sound.play(file: "tapSound.wav")
        
        let alertController = UIAlertController(title: "Upadte Country",
                                                message: "Please enter country initials from follwing format.\n"
                                                    + "\nUS, AU, FR, JP, IN, NZ\n",
                                                preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields?[0] {
                self.country = field.text!
                self.getNewsData(url: self.newsUrl)
                self.title = "Headlines - \(self.country)"
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    //MARK: - Netwroking
    /*********************************************************/
    
    private func getNewsData(url: String) {
        let params : [String : String] = ["apiKey" : apiKey, "country" : country]
        //Progress message
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.show(withStatus: "Fetching latest headlines")
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            if response.result.isSuccess {
                
                let newsJSON : JSON  = JSON(response.result.value!)
                
                self.updateNews(json: newsJSON)
                
                //Dismiss progress message
                SVProgressHUD.dismiss()
            }
            else {
                print("Error from api: \(String(describing: response.result.value))")
                //Dismiss progress message
                SVProgressHUD.dismiss()
                
                self.buildAlert(title: "Connection Problem",
                           body: "Please check that if the device is connected to the internet",
                           button: "Dismiss")
            }
        }
    }
    
    
    //MARK: - JSON Parsing
    /*********************************************************/
    
    private func updateNews(json: JSON) {
        
        var array = [NewsDataTemplate]()
        
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
                if let publishedAt = json["articles"][i]["publishedAt"].string {
                    news.publishedAt = publishedAt
                }
                if let url = json["articles"][i]["url"].string {
                    news.url = url
                }
                
                array.append(news)
            }
            else {
                print("Fetch failed")
                
                buildAlert(title: "Invalid", body: "Invalid serach parameters added", button: "Dismiss")
                self.title = "Headlines"
            }
            newsArray = array
            newsTable.reloadData()
        }
    }
    private func buildAlert(title: String, body: String, button: String) {
        
        //Build alert
        let alert = UIAlertController(title: title,
                                      message: body,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString(button, comment: "Default action"), style: .`default`, handler: nil))
        Sound.play(file: "errorSound.wav")
        self.present(alert, animated: true, completion: nil)
    }
}
