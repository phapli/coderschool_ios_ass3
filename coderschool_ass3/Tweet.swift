//
//  Tweet.swift
//  coderschool_ass3
//
//  Created by Tran Tien Tin on 7/1/17.
//  Copyright © 2017 phapli. All rights reserved.
//

import Foundation

class Tweet: NSObject{
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favouritesCount: Int = 0
    var retweeted: Bool?
    var user: User?
    
    init(dictionary: NSDictionary) {
        print(dictionary)
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favouritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)! as NSDate
        }
        
        let retweeted_status = dictionary["retweeted_status"] as? NSDictionary
        if (retweeted_status != nil){
            
        }
        
        let userDictionary = dictionary["user"] as? NSDictionary
        if let userDictionary = userDictionary {
            user = User(dictionary: userDictionary)
        }
        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
