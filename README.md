# EVPlayer

<p align="center" >
<img src="https://user-images.githubusercontent.com/73871735/228503759-255a4a44-cb40-41a4-86cc-3ee4ae947cea.png" alt="Logo" title="Logo" width=300>
</p>

[![Version](https://img.shields.io/cocoapods/v/EVPlayer.svg?style=flat)](https://cocoapods.org/pods/EVPlayer)
[![License](https://img.shields.io/cocoapods/l/EVPlayer.svg?style=flat)](https://cocoapods.org/pods/EVPlayer)
[![Platform](https://img.shields.io/cocoapods/p/EVPlayer.svg?style=flat)](https://cocoapods.org/pods/EVPlayer)
![Swift 4.2](https://img.shields.io/badge/Swift-5-orange.svg)

``EVPlayer`` is a customized UIView with ``AVPlayer``, which makes video playback extremely easy with its various usage options

### :rocket: Features
- [x] Autoplay mode
- [x] Loop mode
- [x] Switch to full-screen mode synchronously
- [x] Seek animations
- [x] Double tap seek opportunity
- [x] Persistence player to resume playback after bad network connection
- [x] Get relevant player states (quickPlay, play, pause, thumbnail, restart, ended)
- [x] Thumbnail cover
- [x] Selectable supported orientations for full screen mode
- [x] Selectable seek durations for forward and backward (5, 10, 15, 30 seconds, ...)
- [x] Get current & total time, loaded range and, full-screen mode life cycle
- [x] Interface unit tests available
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

## ▶️ Getting started

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
config.shouldAutoPlay = true
config.shouldLoopVideo = true
config.videoGravity = .resizeAspect
config.isFullScreenModeSupported = false
config.fullScreenVideoGravity = .resize
config.forwardSeekDuration = .k15
config.rewindSeekDuration = .k45
config.isFullScreenShouldOpenWithLandscapeMode = true
config.progressBarMaximumTrackTintColor = .blue
config.progressBarMinimumTrackTintColor = .green
```
> Start loading operation with configuration
```swift
evPlayer.load(with: config)
```

![EVGIF2](https://user-images.githubusercontent.com/73871735/228190077-45d5d9b1-21b4-4777-89ba-d373abb90fdf.gif) ![EVGIF3](https://user-images.githubusercontent.com/73871735/228190017-eb2b25e6-5565-42e6-8b5d-51d99b9bc535.gif)


**EVPlayerController Usage**
```swift
let config = EVConfiguration(media: media)
        
EVPlayerController.startFullScreenMode(withConfiguration: config)

```

![EVGIF4](https://user-images.githubusercontent.com/73871735/228203021-6daebeea-2960-4a18-b3cf-170b2d7561c3.gif)

## 🛠️ Customization

EVPlayer comes with several customizable features. You can customize these features on EVConfiguration file;

📌 **_shouldAutoPlay: Bool_**

      A Boolean value that determines whether the player should start playing automatically when the player is loaded.
      ⏯️ Default is NO
     
📌 **_shouldLoopVideo: Bool_**

      A Boolean value that determines whether the video should restart automatically from the beginning when it reaches the end.
      ⏯️ Default is NO
   
📌 **_videoGravity: AVLayerVideoGravity_**
    
      The gravity of the video layer that determines how the video is displayed within the layer bounds.
      ⏯️ Default is AVLayerVideoGravity.resize
      
📌 **_fullScreenModeVideoGravity: AVLayerVideoGravity_**
    
      The gravity of the full-screen mode video layer that determines how the video is displayed within the layer bounds.
      ⏯️ Default is AVLayerVideoGravity.resizeAspect
         
📌 **_isSeekAnimationsEnabled: Bool_**

      A Boolean value that determines whether seek animations should be enabled.
      ⏯️ Default is YES
     
📌 **_forwardSeekDuration: EVSeekDuration_**
  
      The time duration that the player should seek forward when the user taps the forward button.
      ⏯️ Default is k10 (10 seconds)

📌 **_rewindSeekDuration: EVSeekDuration_**

      The time duration that the player should seek rewind when the user taps the rewind button.
      ⏯️ Default is k10 (10 seconds)
      
📌 **_isFullScreenModeSupported: Bool_**

      A Boolean value that determines whether the full-screen mode supported.
      ⏯️ Default is YES
      
📌 **_isFullScreenShouldOpenWithLandscapeMode: Bool_**

      A Boolean value that determines whether the player should be presented in full-screen mode with landscape orientation.
      ⏯️ Default is NO, meaning the player will be presented in full-screen mode with portrait orientation.
    
📌 **_isFullScreenShouldAutoRotate: Bool_**

      A Boolean value that determines whether the player should rotate to match the device orientation when the device is rotated at full-screen mode.
      ⏯️ Default is YES
    
📌 **_fullScreenSupportedInterfaceOrientations: UIInterfaceOrientationMask_**

      The supported interface orientations for the player when it is presented in full-screen mode.
      ⏯️ Default is UIInterfaceOrientationMask.allButUpsideDown
    
📌 **_fullScreenPresentationStyle: UIModalPresentationStyle_**

      The presentation style to use when presenting the player in full-screen mode.
      ⏯️ Default is UIModalPresentationStyle.fullScreen
     
📌 **_thumbnailContentMode: UIView.ContentMode_**
  
      The content mode of thumbnail imageView.
      ⏯️ Default is UIView.ContentMode.scaleToFill

📌 **_progressBarMinimumTrackTintColor: UIColor_**

      The tint color of the minimum track of the progress bar, which represents the progress of the video playback.
      ⏯️ Default is UIColor.orange
    
📌 **_progressBarMaximumTrackTintColor: UIColor_**

      The tint color of the maximum track of the progress bar, which represents the remaining time of the video playback.
      ⏯️ Default is UIColor.lightGray with an alpha component of 0.8.
     
📌 **_isTransactionAnimated: Bool_**

      A Boolean value that determines whether the player transition to full-screen mode should be animated. 
      ⏯️ Default is YES
     
 
## 🖇️ Delegate

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

## 🙋🏻‍♂️ Author

Emirhan Saygıver
- [Linkedin][2]
- [Twitter][3] (@esaygiver)

[2]: https://www.linkedin.com/in/emirhansaygıver/
[3]: https://twitter.com/esaygiver

## ❓Questions or Advices

Just send me an email (saygivere@gmail.com)


## 📔 License

EVPlayer is available under the MIT license. See the LICENSE file for more info.
