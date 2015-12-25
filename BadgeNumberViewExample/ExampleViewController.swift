//
//  ExampleViewController.swift
//  BadgeNumberViewExample
//
//  Created by 洪鑫 on 15/12/23.
//  Copyright © 2015年 Teambition. All rights reserved.
//

import UIKit
import BadgeNumberView

class ExampleViewController: UITableViewController {

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Helper
    private func setupUI() {
        navigationItem.title = "BadgeNumberView Example"
    }

    // MARK: - TableView data source and delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 30))
        let titleLabel = UILabel(frame: CGRectMake(20, (45 - 20) / 2, 150, 20))
        titleLabel.text = "Unread Messages"
        let badgeView = BadgeNumberView(frame: CGRectMake(170, (45 - 18) / 2, 20, 20))
        let badge = badgeForHeaderView(section)
        badgeView.setBadge(text: badge.text, font: UIFont.systemFontOfSize(13), textColor: UIColor.whiteColor(), backgroundColor: UIColor.blueColor())
        headerView.addSubview(titleLabel)
        headerView.addSubview(badgeView)
        badgeView.autoSize = false
        badgeView.setBadgeSize(badge.size)
        return headerView
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MessageCellID, forIndexPath: indexPath) as! MessageCell
        cell.fill(number: badgenNumberWithIndexPath(indexPath))
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    func badgenNumberWithIndexPath(indexPath: NSIndexPath) -> Int {
        switch indexPath.section {
        case 0:
            return indexPath.row
        default:
            return Int(pow(Double(10), Double(indexPath.section))) + indexPath.row
        }
    }

    func badgeForHeaderView(section: Int) -> (text: String, size: CGSize) {
        switch section {
        case 0:
            return (String(6), CGSizeMake(18, 18))
        case 1:
            return (String(22), CGSizeMake(26, 18))
        case 2:
            return (String(167), CGSizeMake(34, 18))
        default:
            return ("999+", CGSizeMake(40, 18))
        }
    }
}

