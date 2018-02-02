//
//  NewsDetailViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 2/2/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit

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

    func setUI() {
        newsTitle.text = newsDetail?.title
        newsDesc.text = newsDetail?.description
        pDate.text = newsDetail?.publishedAt
        source.text = newsDetail?.source
    }

}
