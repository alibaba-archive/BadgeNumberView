//
//  MessageCell.swift
//  BadgeNumberViewExample
//
//  Created by 洪鑫 on 15/12/23.
//  Copyright © 2015年 Teambition. All rights reserved.
//

import UIKit
import BadgeNumberView

let MessageCellID = "MessageCell"

class MessageCell: UITableViewCell {
    @IBOutlet weak var badgeNumberView: BadgeNumberView!

    override func awakeFromNib() {
        super.awakeFromNib()

//        badgeNumberView.cornerRadius = 5
        badgeNumberView.setBadge(number: 6, font: UIFont.systemFontOfSize(14), textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), height: 18)
    }

}
