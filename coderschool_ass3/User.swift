//
//  User.swift
//  coderschool_ass3
//
//  Created by Tran Tien Tin on 7/2/17.
//  Copyright © 2017 phapli. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var tagline: String?
    
    var dictionary: NSDictionary?
    init(dictionary: NSDictionary) {
//        print (dictionary)
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let userDefault = UserDefaults.standard
                
                let data = userDefault.object(forKey: "currentUser")  as? Data
                if let data = data {
                    let dictionary = try!JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
                
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let userDefault = UserDefaults.standard
            if let user = user {
                let data = try!JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                userDefault.setValue(data, forKey: "currentUser")
            } else {
                userDefault.setValue(nil, forKey: "currentUser")
            }
            userDefault.synchronize()
        }
    }
}
