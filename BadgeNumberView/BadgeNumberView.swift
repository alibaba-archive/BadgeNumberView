//
//  BadgeNumberView.swift
//  BadgeNumberView
//
//  Created by Xin Hong on 15/12/23.
//  Copyright © 2015年 Teambition. All rights reserved.
//

import UIKit

open class BadgeNumberView: UIView {
    open var hidesWhenZero = false
    open var autoSize = true
    open var autoSizeOffset: (width: CGFloat, height: CGFloat) = (0, 0)

    fileprivate var badgeBackgroundColor: UIColor?
    fileprivate var badge: (text: String, font: UIFont, textColor: UIColor)?
    fileprivate var size = CGSize(width: 0, height: 0)

    // MARK: - Configuration
    open func setBadge(text: String, font: UIFont, textColor: UIColor, backgroundColor: UIColor) {
        let needUpdate = badge?.text != text || badge?.font != font
        self.backgroundColor = UIColor.clear
        badgeBackgroundColor = backgroundColor
        badge = (text, font, textColor)

        if hidesWhenZero && text == "0" {
            isHidden = true
            return
        }

        isHidden = false
        if autoSize {
            let badgeSize = sizeForBadge(text, font: font, textColor: textColor)
            if badgeSizeNeedUpdate(withSize: badgeSize) {
                updateBadgeHeight(badgeSize.height)
                updateBadgeWidth(badgeSize.width)
                setNeedsDisplay()
            }
        } else if needUpdate {
            setNeedsDisplay()
        }
    }

    open func setBadgeSize(_ size: CGSize) {
        if autoSize {
            return
        }
        if !badgeSizeNeedUpdate(withSize: size) {
            return
        }

        updateBadgeHeight(size.height)
        updateBadgeWidth(size.width)
        setNeedsDisplay()
    }

    open override func draw(_ rect: CGRect) {
        if let badgeBackgroundColor = badgeBackgroundColor, let badge = badge {
            let badgeBackground = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2)
            badgeBackgroundColor.setFill()
            badgeBackground.fill()
            drawBadgeString(text: badge.text, font: badge.font, textColor: badge.textColor)
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Size related
    fileprivate func sizeForBadge(_ text: String, font: UIFont, textColor: UIColor) -> CGSize {
        let fitHeight = ceil(font.lineHeight)
        let fitWidth = ceil(attributedBadgeString(text: text, font: font, textColor: textColor).size.width)

        let height = ceil(fitHeight + autoSizeOffset.height)
        let width: CGFloat = {
            if text.count <= 1 {
                return height
            }
            let width = fitWidth + height / 2
            return ceil(width + autoSizeOffset.width)
        }()
        return CGSize(width: width, height: height)
    }

    fileprivate func heightConstraint() -> (available: Bool, constraint: NSLayoutConstraint?) {
        for constraint in constraints {
            if constraint.firstAttribute == .height {
                return (true, constraint)
            }
        }
        return (false, nil)
    }

    fileprivate func widthConstraint() -> (available: Bool, constraint: NSLayoutConstraint?) {
        for constraint in constraints {
            if constraint.firstAttribute == .width {
                return (true, constraint)
            }
        }
        return (false, nil)
    }

    fileprivate func updateBadgeHeight(_ height: CGFloat) {
        if translatesAutoresizingMaskIntoConstraints {
            // BadgeNumberView is programmatically created
            frame.size.height = height
        } else {
            // BadgeNumberView is created in Interface Builder and using autolayout
            if let heightConstraint = heightConstraint().constraint {
                heightConstraint.constant = height
            } else {
                addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: height))
            }
            layoutIfNeeded()
        }
        size.height = height
    }

    fileprivate func updateBadgeWidth(_ width: CGFloat) {
        if translatesAutoresizingMaskIntoConstraints {
            // BadgeNumberView is programmatically created
            frame.size.width = width
        } else {
            // BadgeNumberView is created in Interface Builder and using autolayout
            if let widthConstraint = widthConstraint().constraint {
                widthConstraint.constant = width
            } else {
                addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: width))
            }
            layoutIfNeeded()
        }
        size.width = width
    }

    fileprivate func badgeSizeNeedUpdate(withSize newSize: CGSize) -> Bool {
        return size != newSize
    }

    // MARK: - Helper
    fileprivate func attributedBadgeString(text: String, font: UIFont, textColor: UIColor) -> (string: NSAttributedString, attributes: [NSAttributedStringKey: Any], size: CGSize) {
        let attributes: [NSAttributedStringKey: Any] = [.foregroundColor: textColor, .font: font]
        let attributedBadgeString = NSAttributedString(string: text, attributes: attributes)
        let attributedBadgeStringFrame = attributedBadgeString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        return (attributedBadgeString, attributes, attributedBadgeStringFrame.size)
    }

    fileprivate func drawBadgeString(text: String, font: UIFont, textColor: UIColor) {
        let attributedBadge = attributedBadgeString(text: text, font: font, textColor: textColor)
        var attributes = attributedBadge.attributes
        let attributedBadgeSize = attributedBadge.size

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attributes.updateValue(paragraphStyle, forKey: NSAttributedStringKey.paragraphStyle)
        let baselineOffset = -(bounds.height - attributedBadgeSize.height) / 2
        attributes.updateValue(baselineOffset, forKey: NSAttributedStringKey.baselineOffset)
        let finalAttributedBadgeNumber = NSAttributedString(string: text, attributes: attributes)
        finalAttributedBadgeNumber.draw(in: bounds)
    }
}
