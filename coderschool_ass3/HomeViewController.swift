//
//  HomeViewController.swift
//  coderschool_ass3
//
//  Created by Tran Tien Tin on 7/1/17.
//  Copyright © 2017 phapli. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var tweets = [Tweet]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
        reload()
    }

    func reload(){
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print ("error \(error.localizedDescription)")
        })
    }

    @IBAction func doNew(_ sender: Any) {
    }
    @IBAction func d(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
}
