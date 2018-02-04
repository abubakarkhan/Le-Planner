//
//  NewsDetailViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 2/2/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit
import SafariServices

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDesc: UILabel!
    @IBOutlet weak var pDate: UILabel!
    @IBOutlet weak var source: UILabel!
    
    var newsDetail : NewsDataTemplate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    private func setUI() {
        newsTitle.text = newsDetail?.title
        newsDesc.text = newsDetail?.description
        pDate.text = newsDetail?.publishedAt
        source.text = newsDetail?.source
        //newsDetail?.url = ""
    }

    @IBAction func viewDetails(_ sender: Any) {
        
        if newsDetail != nil {
            if !(newsDetail?.url.isEmpty)!{
                let newsUrl = URL(string: (newsDetail?.url)!)
                let safariVC = SFSafariViewController(url: newsUrl!)
                present(safariVC, animated: true, completion: nil)
            }
            else {
                let button = sender as AnyObject
                button.setTitle(" URL Not Available ", for: .normal)
            }
        }
    }
    
}
