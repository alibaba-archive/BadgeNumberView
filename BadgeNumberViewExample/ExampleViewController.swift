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
    fileprivate func setupUI() {
        navigationItem.title = "BadgeNumberView Example"
    }

    // MARK: - TableView data source and delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        let titleLabel = UILabel(frame: CGRect(x: 20, y: (45 - 20) / 2, width: 150, height: 20))
        titleLabel.text = "Unread Messages"
        let badgeView = BadgeNumberView(frame: CGRect(x: 170, y: (45 - 18) / 2, width: 20, height: 20))
        let badge = badgeForHeaderView(section)
        badgeView.setBadge(text: badge.text, font: .systemFont(ofSize: 13), textColor: .white, backgroundColor: .blue)
        headerView.addSubview(titleLabel)
        headerView.addSubview(badgeView)
        badgeView.autoSize = false
        badgeView.setBadgeSize(badge.size)
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCellID, for: indexPath) as! MessageCell
        cell.fill(badgenNumberWithIndexPath(indexPath))
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func badgenNumberWithIndexPath(_ indexPath: IndexPath) -> Int {
        switch indexPath.section {
        case 0:
            return indexPath.row
        default:
            return Int(pow(Double(10), Double(indexPath.section))) + indexPath.row
        }
    }

    func badgeForHeaderView(_ section: Int) -> (text: String, size: CGSize) {
        switch section {
        case 0:
            return (String(6), CGSize(width: 18, height: 18))
        case 1:
            return (String(22), CGSize(width: 26, height: 18))
        case 2:
            return (String(167), CGSize(width: 34, height: 18))
        default:
            return ("999+", CGSize(width: 40, height: 18))
        }
    }
}

