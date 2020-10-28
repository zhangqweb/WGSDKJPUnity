#
# Be sure to run `pod lib lint WGSDKJPUnity.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WGSDKJPUnity'
  s.version          = '0.0.1'
  s.summary          = 'games WGSDKJPUnity.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/zhangqweb/WGSDKJPUnity'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhangqweb@126.com' => 'zhangqweb@126.com' }
  s.source           = { :git => 'https://github.com/zhangqweb/WGSDKJPUnity.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'WGSDKJPUnity/Classes/**/*'
#  s.vendored_frameworks = 'WGSDKJPUnity/Frameworks/WGSDKJPUnity.xcframework'
  
  s.xcconfig = {
  'VALID_ARCHS' =>  'armv7 arm64 x86_64',
  }
  
  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true

  s.swift_version = ['5.0', '5.1', '5.2', '5.3']
  
  s.static_framework = true

  s.dependency 'WGSDKJP','0.0.18'
  
  
end
