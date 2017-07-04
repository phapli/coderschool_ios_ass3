//
//  LoginViewController.swift
//  coderschool_ass3
//
//  Created by Tran Tien Tin on 6/28/17.
//  Copyright © 2017 phapli. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let client = TwitterClient.sharedInstance
        client?.login(success: { 
            //
            print("loged in")
//            self.performSegue(withIdentifier: "loginSeque", sender: nil)
            
        }, failure: { (error: Error) in
            print("error \(error.localizedDescription)")
        })
    
    }
}

