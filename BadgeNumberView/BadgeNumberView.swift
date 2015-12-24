//
//  BadgeNumberView.swift
//  BadgeNumberView
//
//  Created by Xin Hong on 15/12/23.
//  Copyright © 2015年 Teambition. All rights reserved.
//

import UIKit

public class BadgeNumberView: UIView {
    public var hidesWhenZero = false
    public var autoSize = true
    public var autoSizeOffset: (width: CGFloat, height: CGFloat) = (0, 0)

    private var badgeBackgroundColor: UIColor?
    private var badge: (text: String, font: UIFont, textColor: UIColor)?

    // MARK: - Configuration
    public func setBadge(text text: String, font: UIFont, textColor: UIColor, backgroundColor: UIColor) {
        if hidesWhenZero && text == "0" {
            hidden = true
            return
        }

        hidden = false
        self.backgroundColor = UIColor.clearColor()
        badgeBackgroundColor = backgroundColor
        badge = (text, font, textColor)

        if autoSize {
            let badgeSize = sizeForBadge(text, font: font, textColor: textColor)
            updateBadgeHeight(badgeSize.height)
            updateBadgeWidth(badgeSize.width)
            setNeedsDisplay()
        }
    }

    public func setBadgeSize(size: CGSize) {
        if autoSize {
            return
        }

        updateBadgeHeight(size.height)
        updateBadgeWidth(size.width)
        setNeedsDisplay()
    }

    public override func drawRect(rect: CGRect) {
        if let badgeBackgroundColor = badgeBackgroundColor, badge = badge {
            let badgeBackground = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2)
            badgeBackgroundColor.setFill()
            badgeBackground.fill()
            drawBadgeString(text: badge.text, font: badge.font, textColor: badge.textColor)
        }
    }

    // MARK: - Size related
    private func sizeForBadge(text: String, font: UIFont, textColor: UIColor) -> CGSize {
        let fitHeight = ceil(font.lineHeight)
        let fitWidth = ceil(attributedBadgeString(text: text, font: font, textColor: textColor).size.width)

        let height = ceil(fitHeight + autoSizeOffset.height)
        let width: CGFloat = {
            if text.characters.count <= 1 {
                return height
            }
            let width = fitWidth + height / 2
            return ceil(width + autoSizeOffset.width)
        }()
        return CGSizeMake(width, height)
    }

    private func heightConstraint() -> (available: Bool, constraint: NSLayoutConstraint?) {
        for constraint in constraints {
            if constraint.firstAttribute == .Height {
                return (true, constraint)
            }
        }
        return (false, nil)
    }

    private func widthConstraint() -> (available: Bool, constraint: NSLayoutConstraint?) {
        for constraint in constraints {
            if constraint.firstAttribute == .Width {
                return (true, constraint)
            }
        }
        return (false, nil)
    }

    private func updateBadgeHeight(height: CGFloat) {
        if translatesAutoresizingMaskIntoConstraints {
            // BadgeNumberView is programmatically created
            frame.size.height = height
        } else {
            // BadgeNumberView is created in Interface Builder and using autolayout
            if let heightConstraint = heightConstraint().constraint {
                heightConstraint.constant = height
            } else {
                addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: height))
            }
            layoutIfNeeded()
        }
    }

    private func updateBadgeWidth(width: CGFloat) {
        if translatesAutoresizingMaskIntoConstraints {
            // BadgeNumberView is programmatically created
            frame.size.width = width
        } else {
            // BadgeNumberView is created in Interface Builder and using autolayout
            if let widthConstraint = widthConstraint().constraint {
                widthConstraint.constant = width
            } else {
                addConstraint(NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: width))
            }
            layoutIfNeeded()
        }
    }

    // MARK: - Helper
    private func attributedBadgeString(text text: String, font: UIFont, textColor: UIColor) -> (string: NSAttributedString, attributes: [String: AnyObject], size: CGSize) {
        let attributes = [NSForegroundColorAttributeName: textColor, NSFontAttributeName: font]
        let attributedBadgeString = NSAttributedString(string: text, attributes: attributes)
        let attributedBadgeStringFrame = attributedBadgeString.boundingRectWithSize(CGSizeMake(CGFloat.max, CGFloat.max), options: .UsesLineFragmentOrigin, context: nil)
        return (attributedBadgeString, attributes, attributedBadgeStringFrame.size)
    }

    private func drawBadgeString(text text: String, font: UIFont, textColor: UIColor) {
        let attributedBadge = attributedBadgeString(text: text, font: font, textColor: textColor)
        var attributes = attributedBadge.attributes
        let attributedBadgeSize = attributedBadge.size

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        attributes.updateValue(paragraphStyle, forKey: NSParagraphStyleAttributeName)
        let baselineOffset = -(bounds.height - attributedBadgeSize.height) / 2
        attributes.updateValue(baselineOffset, forKey: NSBaselineOffsetAttributeName)
        let finalAttributedBadgeNumber = NSAttributedString(string: text, attributes: attributes)
        finalAttributedBadgeNumber.drawInRect(bounds)
    }
}
