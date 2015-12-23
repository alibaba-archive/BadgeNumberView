//
//  MessageCell.swift
//  BadgeViewExample
//
//  Created by 洪鑫 on 15/12/23.
//  Copyright © 2015年 Teambition. All rights reserved.
//

import UIKit
import BadgeView

let MessageCellID = "MessageCell"

class MessageCell: UITableViewCell {
    @IBOutlet weak var badgeView: BadgeView!

    override func awakeFromNib() {
        super.awakeFromNib()

//        badgeView.cornerRadius = 5
        badgeView.setBadge(number: 6, font: UIFont.systemFontOfSize(14), textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), height: 18)
    }

}
