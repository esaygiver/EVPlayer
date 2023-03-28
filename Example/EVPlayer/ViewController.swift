//
//  ViewController.swift
//  EVPlayer
//
//  Created by esaygiver on 03/16/2023.
//  Copyright (c) 2023 esaygiver. All rights reserved.
//

import UIKit
import EVPlayer

class ViewController: UIViewController {
        
    private(set) var evPlayer: EVPlayer!
    private var showEVPlayerControllerButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureEVPlayer()
        configureFullScreenButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(evPlayer)
        evPlayer.center = view.center
        
        view.addSubview(showEVPlayerControllerButton)
        NSLayoutConstraint.activate([
            showEVPlayerControllerButton.widthAnchor.constraint(equalToConstant: 200),
            showEVPlayerControllerButton.heightAnchor.constraint(equalToConstant: 50),
            showEVPlayerControllerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showEVPlayerControllerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 225)
         ])
    }
    
    private func configureEVPlayer() {
        evPlayer = EVPlayer(frame: CGRect(x: 0, y: 0, width: 400, height: 225))

        evPlayer.delegate = self
        
        let media = EVMedia(videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4")!,
                            thumbnailURL: URL(fileURLWithPath: Bundle.main.path(forResource: "defaultThumbnail2", ofType: "png") ?? ""))
        
        let config = EVConfiguration(media: media)
        
        /// Customizable properties
//        config.isFullScreenModeSupported = false
//        config.progressBarMinimumTrackTintColor = .green
//        config.forwardSeekDuration = .k15
//        config.rewindSeekDuration = .k45
//        config.shouldAutoPlay = true
//        config.fullScreenModeVideoGravity = .resize
//        config.isFullScreenShouldOpenWithLandscapeMode = true
//        config.shouldLoopVideo = true
//        config.videoGravity = .resizeAspect
        
        evPlayer.load(with: config)
    }
    
    private func configureFullScreenButton() {
        showEVPlayerControllerButton = UIButton()
        showEVPlayerControllerButton.setTitle("Open Full-Screen Mode", for: .normal)
        showEVPlayerControllerButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        showEVPlayerControllerButton.setTitleColor(.orange, for: .normal)
        showEVPlayerControllerButton.backgroundColor = .lightGray.withAlphaComponent(0.2)
        showEVPlayerControllerButton.layer.cornerRadius = 12.0
        showEVPlayerControllerButton.addTarget(self, action: #selector(showEVPlayerController), for: .touchUpInside)
        showEVPlayerControllerButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc
    private func showEVPlayerController() {
        /// Create media
        let media = EVMedia(videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4")!,
                            thumbnailURL: URL(fileURLWithPath: Bundle.main.path(forResource: "defaultThumbnail2", ofType: "png") ?? ""))
        
        /// Create conifg with media
        var config = EVConfiguration(media: media)
        
        /// Customize
        config.shouldAutoPlay = true
        config.thumbnailContentMode = .scaleAspectFit
        config.videoGravity = .resizeAspect
        
        /// Starts full-screen transaction
        EVPlayerController.startFullScreenMode(withConfiguration: config)
    }
}

extension ViewController: EVPlayerDelegate {
        
    func evPlayer(stateDidChangedTo state: EVVideoState) { }
    
    func evPlayer(timeChangedTo currentTime: Double, totalTime: Double, loadedRange: Double) { }
    
    func evPlayer(fullScreenTransactionUpdateTo state: EVFullScreenState) { }
}
