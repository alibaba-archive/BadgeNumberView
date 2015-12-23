//
//  BadgeView.swift
//  BadgeView
//
//  Created by 洪鑫 on 15/12/23.
//  Copyright © 2015年 Teambition. All rights reserved.
//

import UIKit

public class BadgeView: UILabel {
    public var cornerRadius: CGFloat? {
        didSet {
            setNeedsDisplay()
        }
    }
    public var badgeBackgroundColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    public var maxDigit: UInt = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    public var badge: (number: Int, font: UIFont, textColor: UIColor)? {
        didSet {
            if let badge = badge {
                let badgeFrame = attributedBadgeNumber(number: badge.number, font: badge.font, textColor: badge.textColor).frame
                frame.size.height = badgeFrame.height + 10
                frame.size.width = badgeFrame.width + 10
            }
            setNeedsDisplay()
        }
    }

    override public func drawRect(rect: CGRect) {
        let badgeCornerRadius = cornerRadius ?? bounds.height / 2
        if let badgeBackgroundColor = badgeBackgroundColor, badge = badge {
            let badgeBackground = UIBezierPath(roundedRect: bounds, cornerRadius: badgeCornerRadius)
            badgeBackgroundColor.setFill()
            badgeBackground.fill()
            drawBadgeNumber(number: badge.number, font: badge.font, textColor: badge.textColor)
        }
    }

    private func attributedBadgeNumber(number number: Int, font: UIFont, textColor: UIColor) -> (attributes: [String: AnyObject], frame: CGRect) {
        let attributes = [NSForegroundColorAttributeName: textColor, NSFontAttributeName: font]
        let attributedBadgeNumber = NSAttributedString(string: String(number), attributes: attributes)
        let attributedBadgeNumberFrame = attributedBadgeNumber.boundingRectWithSize(CGSizeMake(CGFloat.max, CGFloat.max), options: .UsesLineFragmentOrigin, context: nil)
        return (attributes, attributedBadgeNumberFrame)
    }

    private func drawBadgeNumber(number number: Int, font: UIFont, textColor: UIColor) {
        let attributedNumber = attributedBadgeNumber(number: number, font: font, textColor: textColor)
        var attributes = attributedNumber.attributes
        let attributedBadgeNumberFrame = attributedNumber.frame

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        attributes.updateValue(paragraphStyle, forKey: NSParagraphStyleAttributeName)
        let baselineOffset = -(bounds.height - attributedBadgeNumberFrame.height) / 2
        attributes.updateValue(baselineOffset, forKey: NSBaselineOffsetAttributeName)
        let finalAttributedBadgeNumber = NSAttributedString(string: String(number), attributes: attributes)
        finalAttributedBadgeNumber.drawInRect(bounds)
    }
}
