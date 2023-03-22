#
# Be sure to run `pod lib lint EVPlayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EVPlayer'
  s.version          = '0.1.1'
  s.summary          = 'EVPlayer has very easy usage & set up and, offers an interface enhanced with animations.'

  s.description      = 'EVPlayer is a customized UIView with AVPlayer inside. With multiple states, it makes video playback extremely easy for the user.'

  s.homepage         = 'https://github.com/esaygiver/EVPlayer'
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

end
