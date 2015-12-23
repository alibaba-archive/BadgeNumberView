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
    public var maxDigit: UInt = 3 {
        didSet {
            setNeedsDisplay()
        }
    }

    private var badgeBackgroundColor: UIColor?
    private var badge: (number: Int, font: UIFont, textColor: UIColor)?

    public func setBadge(number number: Int, font: UIFont, textColor: UIColor, backgroundColor: UIColor, height: CGFloat? = nil) {
        let badgeFrame = attributedBadgeNumber(number: number, font: font, textColor: textColor).frame
        let height = height ?? badgeFrame.height
        let width = height
        for constraint in constraints {
            if constraint.firstAttribute == .Height || constraint.firstAttribute == .Width {
                removeConstraint(constraint)
            }
        }

        addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: height))
        addConstraint(NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: width))
        layoutIfNeeded()

        badgeBackgroundColor = backgroundColor
        badge = (number, font, textColor)
        setNeedsDisplay()
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
        let attributedBadge = attributedBadgeNumber(number: number, font: font, textColor: textColor)
        var attributes = attributedBadge.attributes
        let attributedBadgeNumberFrame = attributedBadge.frame

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        attributes.updateValue(paragraphStyle, forKey: NSParagraphStyleAttributeName)
        let baselineOffset = -(bounds.height - attributedBadgeNumberFrame.height) / 2
        attributes.updateValue(baselineOffset, forKey: NSBaselineOffsetAttributeName)
        let finalAttributedBadgeNumber = NSAttributedString(string: String(number), attributes: attributes)
        finalAttributedBadgeNumber.drawInRect(bounds)
    }
}
