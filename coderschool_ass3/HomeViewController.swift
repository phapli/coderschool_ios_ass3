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
    let refreshControl = UIRefreshControl()
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        
        refreshControl.addTarget(self, action: #selector(HomeViewController.reload), for: UIControlEvents.valueChanged)

        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
        reload()
    }

    func reload(){
        present(alert, animated: true, completion: nil)
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }, failure: { (error: Error) in
            print ("error \(error.localizedDescription)")
            self.refreshControl.endRefreshing()
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
