//
//  TwiterClient.swift
//  coderschool_ass3
//
//  Created by Tran Tien Tin on 6/28/17.
//  Copyright © 2017 phapli. All rights reserved.
//

import Foundation
import AFNetworking
import BDBOAuth1Manager

let baseUrl = "https://api.twitter.com/"
let consumerKey = "86wWct409HQB0Wbog5Vuba4LH"
let consumerSecret = "CCWNZzgxLXff8eM0heYWhRGUrzKaVi5WKcfgwdKDUBcfM7Peik"

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: baseUrl), consumerKey: consumerKey, consumerSecret: consumerSecret)
    //    static let client = BDBOAuth1SessionManager(baseURL: URL(string: baseUrl), consumerKey: consumerKey, consumerSecret: consumerSecret)
    
    static func fetchRequestToken(success: ((BDBOAuth1Credential?) -> Swift.Void)!, failure: ((Error?) -> Swift.Void)!){
        
        sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "POST", callbackURL: URL(string: "coderschool3://"), scope: nil, success: success, failure: failure)
        
        
    }
    
    static func fetchAccessToken (requestToken: BDBOAuth1Credential!, success: ((BDBOAuth1Credential?) -> Swift.Void)!, failure: ((Error?) -> Swift.Void)!) {
        sharedInstance?.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: success, failure: failure)
    }
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "POST", callbackURL: URL(string: "coderschool3://"), scope: nil, success: { (response: BDBOAuth1Credential?) in
            if let response = response {
                print (response.token)
                
                let authURL = URL(string: "https://api.twitter.com/oauth/authenticate?oauth_token=\(response.token!)")
                UIApplication.shared.open(authURL!, options: [:], completionHandler: nil)
                success()
            }
        }, failure: { (error: Error?) in
            failure(error!)
        })
    }
    
    func handleUrl(url: URL){
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (response: BDBOAuth1Credential?) in
            if let response = response {
                print(response.token)
                self.currentAccount(success: { (user: User) in
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: { (error: Error) in
                    self.loginFailure?(error)
                })
                
            }
        }) { (error: Error!) in
            self.loginFailure?(error)
        }

    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogout"), object: nil)
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: { (progress: Progress) in
            //
        }, success: { (_ URLSessionDataTask, data: Any?) in
            //
            let dictionnaries = data as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionnaries)
            success(tweets)
            
        }) { (_ URLSessionDataTask, error: Error) in
            failure(error)
        }
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: { (progress: Progress) in
            //
        }, success: { (_ URLSessionDataTask, data: Any?) in
            //
            let dictionary = data as! NSDictionary
            let user = User(dictionary: dictionary)
            
            success(user)
        }) { (_ URLSessionDataTask, error: Error) in
            failure(error)
        }
    }
    
}

