#
#  Be sure to run `pod spec lint CustomAlertView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "CustomAlertView"
  s.version      = "0.1.0"
  s.summary      = "自定义弹框自定义弹框自定义弹框"
  s.description  = <<-DESC
ftdfygducgececeftdfygducgececeftdfygducgececeftdfygducgececeftdfygducgececeftdfygducgececeftdfygducgececeftdfygducgecece
                   DESC

  s.homepage     = "https://coding.net/u/wenziq/p/CustomAlertView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

    s.author             = { "Fangjw" => "454116036@qq.com" }
  s.author    = "Fangjw"
  # s.authors            = { "Fangjw" => "454116036@qq.com" }
  # s.social_media_url   = "http://twitter.com/Fangjw"

  # s.platform     = :ios
  s.platform     = :ios, "9.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://git.coding.net/wenziq/WenZiSpecs.git", :tag => "0.1.0" }

  # s.source_files  = "Classes", "Classes/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.frameworks  = "UIKit"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "Masonry"

end
