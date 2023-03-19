#
# Be sure to run `pod lib lint EVPlayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EVPlayer'
  s.version          = '0.1.0'
  s.summary          = 'EVPlayer has very easy usage & set up and, offers an interface enhanced with animations.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'EVPlayer is a customized UIView with AVPlayer inside. With multiple states, it makes video playback extremely easy for the user and the developer.'

  s.homepage         = 'https://github.com/esaygiver/EVPlayer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'esaygiver' => 'saygivere@gmail.com' }
  s.source           = { :git => 'https://github.com/esaygiver/EVPlayer.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/esaygiver'

  s.ios.deployment_target = '12.0'
  s.swift_version = "5.0"
  s.platforms = {
      "ios": "12.0"
  }

  s.source_files = 'Source/**/*.swift'
  s.resource = 'Example/Pods/Resources/**/*'
  
  # s.resource_bundles = {
  #   'EVPlayer' => ['EVPlayer/Assets/*.png']
  # }

end
