//
//  TweetCell.swift
//  coderschool_ass3
//
//  Created by Tran Tien Tin on 7/1/17.
//  Copyright © 2017 phapli. All rights reserved.
//

import UIKit
import AFNetworking
import NSDate_TimeAgo

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var tweet: Tweet! {
        didSet {
            contentLabel.text = tweet.text
//            timeLabel.text = tweet.timestamp
            nameLabel.text = tweet.user?.name
            nicknameLabel.text = tweet.user?.screenName
            avatarImage.setImageWith((tweet.user?.profileUrl)!)
            timeLabel.text = tweet.timestamp?.dateTimeAgo()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
