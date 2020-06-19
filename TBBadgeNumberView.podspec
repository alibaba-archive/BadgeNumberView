Pod::Spec.new do |spec|

  spec.name         = "TBBadgeNumberView"
  spec.version      = "0.1.0"
  spec.summary      = "TBBadgeNumberView is a quite lightweight badge view for iOS applications."

  spec.homepage     = "https://github.com/teambition/BadgeNumberView"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author       = { "bruce" => "liangmingzou@163.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/teambition/BadgeNumberView.git", :tag => "#{spec.version}" }
  spec.swift_version = "5.0"

  spec.source_files  = "BadgeNumberView/*.swift"
  spec.frameworks   = "Foundation", "UIKit"

end
