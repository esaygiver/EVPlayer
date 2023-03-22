# EVPlayer

[![Version](https://img.shields.io/cocoapods/v/EVPlayer.svg?style=flat)](https://cocoapods.org/pods/EVPlayer)
[![License](https://img.shields.io/cocoapods/l/EVPlayer.svg?style=flat)](https://cocoapods.org/pods/EVPlayer)
[![Platform](https://img.shields.io/cocoapods/p/EVPlayer.svg?style=flat)](https://cocoapods.org/pods/EVPlayer)
![](https://img.shields.io/badge/Contact-saygivere@gmail.com-yellowgreen.svg)

**``EVPlayer`` is a customized UIView with ``AVPlayer``, which makes video playback extremely easy with its various usage options**

### :rocket: Features
- [x] Autoplay mode
- [x] Loop mode
- [x] Switch to full-screen mode synchronously
- [x] Seek animations
- [x] Persistence player to resume playback after bad network connection
- [x] Get relevant player states (quickPlay, play, pause, thumbnail, restart, ...)
- [x] Customizable thumbnail
- [x] Selectable supported orientations for full screen mode
- [x] Selectable seek durations for forward and backward (5, 10, 15, 30 seconds, ...)
- [x] Get current & total time, loaded range and, full-screen mode life cycle
- [x] Log available
***

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 12.0+

## Installation

**Using CocoaPods**

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate ``EVPlayer`` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'EVPlayer'
end
```

Then, run the following command:

```bash
$ pod install
```

**Manual**

Download the project, just drag and drop classes under **Source** file to your project.

## Getting started

> Create EVPlayer object
```swift
let evPlayer = EVPlayer(frame: CGRect(x: 0, y: 0, width: 350, height: 200))
view.addSubview(evPlayer)
evPlayer.center = view.center
```
> Create media with video URL and optional thumbnail URL
```swift
let media = EVMedia(videoURL: URL, thumbnailURL: URL?)
```
> Create configuration with media
```swift
let config = EVConfiguration(media: media)
```
> Configuration can be customize
```swift
config.videoGravity = .resizeAspect
config.fullScreenVideoGravity = .resize
config.shouldAutoPlay = true
config.shouldLoopVideo = true
config.forwardSeekDuration = .k30
config.rewindSeekDuration = .k90
config.isFullScreenShouldOpenWithLandscapeMode = true
config.progressBarMaximumTrackTintColor = .blue
config.progressBarMinimumTrackTintColor = .green
```
> Start loading operation with configuration
```swift
evPlayer.load(with: config)
```
> EVPlayer screen recordings (Portrait & Landscape full screen mode, ended scene)

![EVPLayer-SR2](https://user-images.githubusercontent.com/73871735/226729453-e167f6af-5b20-4fb4-887b-d4f1b7a8b5ed.gif) ![EVPlayer-SR3](https://user-images.githubusercontent.com/73871735/226735395-3f4e336a-4ddc-4a66-8da5-769504061e66.gif) ![EVPlayer-SR4](https://user-images.githubusercontent.com/73871735/226738241-2a49d80e-6f82-48d9-8ad0-400f0c7ad8fd.gif)

**EVPlayerController Usage**
```swift
let config = EVConfiguration(media: media)
        
EVPlayerController.startFullScreenMode(withConfiguration: config)

```
> EVPlayerController screen recordings

![EVPlayerController-VerticalSR](https://user-images.githubusercontent.com/73871735/226662595-a8042207-28d4-48a9-b5cd-f2583e93f4e5.gif)
![EVPlayerController-HorizontalSR](https://user-images.githubusercontent.com/73871735/226662770-3747f6c3-e3af-43e7-91ff-af18903164f2.gif)

## Customization

EVPlayer comes with several customizable features. You can customize these features on EVConfiguration file;

📌 **_shouldAutoPlay: Bool_**

      A Boolean value that determines whether the player should start playing automatically when the player is loaded. Default is NO
     
📌 **_shouldLoopVideo: Bool_**

      A Boolean value that determines whether the video should restart automatically from the beginning when it reaches the end. Default is NO
   
📌 **_videoGravity: AVLayerVideoGravity_**
    
      The gravity of the video layer that determines how the video is displayed within the layer bounds. Default is AVLayerVideoGravity.resize
      
📌 **_fullScreenModeVideoGravity: AVLayerVideoGravity_**
    
      The gravity of the full-screen mode video layer that determines how the video is displayed within the layer bounds. Default is AVLayerVideoGravity.resizeAspect
         
📌 **_isSeekAnimationsEnabled: Bool_**

      A Boolean value that determines whether seek animations should be enabled. Default is YES
     
📌 **_forwardSeekDuration: EVSeekDuration_**
  
      The time duration that the player should seek forward when the user taps the forward button. Default is k10 (10 seconds)

📌 **_rewindSeekDuration: EVSeekDuration_**

      The time duration that the player should seek rewind when the user taps the rewind button. Default is k10 (10 seconds)
      
📌 **_isFullScreenModeSupported: Bool_**

      A Boolean value that determines whether the full-screen mode supported. Default is YES
      
📌 **_isFullScreenShouldOpenWithLandscapeMode: Bool_**

      A Boolean value that determines whether the player should be presented in full-screen mode with landscape orientation. Default is NO, meaning the player will be presented in full-screen mode with portrait orientation.
    
📌 **_isFullScreenShouldAutoRotate: Bool_**

      A Boolean value that determines whether the player should rotate to match the device orientation when the device is rotated at full-screen mode. Default is YES
    
📌 **_fullScreenSupportedInterfaceOrientations: UIInterfaceOrientationMask_**

      The supported interface orientations for the player when it is presented in full-screen mode. Default is UIInterfaceOrientationMask.allButUpsideDown
    
📌 **_fullScreenPresentationStyle: UIModalPresentationStyle_**

      The presentation style to use when presenting the player in full-screen mode. Default is UIModalPresentationStyle.fullScreen
     
📌 **_thumbnailContentMode: UIView.ContentMode_**
  
      The content mode of thumbnail imageView. Defaul is UIView.ContentMode.scaleToFill

📌 **_progressBarMinimumTrackTintColor: UIColor_**

      The tint color of the minimum track of the progress bar, which represents the progress of the video playback. Default is UIColor.orange
    
📌 **_progressBarMaximumTrackTintColor: UIColor_**

      The tint color of the maximum track of the progress bar, which represents the remaining time of the video playback. Default is UIColor.lightGray with an alpha component of 0.8.
     
📌 **_isTransactionAnimated: Bool_**

      A Boolean value that determines whether the player transition to full-screen mode should be animated. Default is YES
     
 
## Delegate

If you want to track current player state, current & total duration, and full screen lifecycle you can set delegate;

```
evPlayer.delegate = self
```

Methods;
```
func evPlayer(stateDidChangedTo state: EVVideoState)
func evPlayer(timeChangedTo currentTime: Double, totalTime: Double, loadedRange: Double)
func evPlayer(fullScreenTransactionUpdateTo state: EVFullScreenState)
```

## Author

Emirhan Saygıver
- [Linkedin][2]
- [Twitter][3] (@esaygiver)

[2]: https://www.linkedin.com/in/emirhansaygıver/
[3]: https://twitter.com/esaygiver

## Questions or Advices

Just send me an email (saygivere@gmail.com)


## License

EVPlayer is available under the MIT license. See the LICENSE file for more info.
