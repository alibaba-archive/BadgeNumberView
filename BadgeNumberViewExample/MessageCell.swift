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

        badgeNumberView.hidesWhenZero = true
        badgeNumberView.autoSize = false
//        badgeNumberView.autoSizeOffset = (3, 2)
    }

    func fill(_ number: Int) {
        badgeNumberView.setBadge(text: String(number), font: UIFont.systemFont(ofSize: 13), textColor: UIColor.white, backgroundColor: UIColor(red: 255 / 255, green: 59 / 255, blue: 48 / 255, alpha: 1))
        badgeNumberView.setBadgeSize(CGSize(width: 18 + CGFloat((String(number).count - 1) * 8), height: 18))
    }
}
