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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureEVPlayer()
//        configureFullScreenButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        evPlayer.changeStateForNavigationChanges(to: .play)
    }
    
    private func configureFullScreenButton() {
        showEVPlayerControllerButton = UIButton()
        showEVPlayerControllerButton.setTitle("Open Full-Screen Mode", for: .normal)
        showEVPlayerControllerButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        showEVPlayerControllerButton.setTitleColor(.orange, for: .normal)
        showEVPlayerControllerButton.backgroundColor = .lightGray.withAlphaComponent(0.2)
        showEVPlayerControllerButton.layer.cornerRadius = 12.0
        showEVPlayerControllerButton.addTarget(self, action: #selector(showEVPlayerControllerButtonTapped), for: .touchUpInside)
        showEVPlayerControllerButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(showEVPlayerControllerButton)
        
        NSLayoutConstraint.activate([
            showEVPlayerControllerButton.widthAnchor.constraint(equalToConstant: 200),
            showEVPlayerControllerButton.heightAnchor.constraint(equalToConstant: 50),
            showEVPlayerControllerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showEVPlayerControllerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
         ])
    }
    
    private func configureEVPlayer() {
        evPlayer = EVPlayer(frame: CGRect(x: 0, y: 0, width: 400, height: 225))

        view.addSubview(evPlayer)
        evPlayer.delegate = self
        evPlayer.center = view.center
        
        let media = EVMedia(videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")!,
                            thumbnailURL: URL(fileURLWithPath: Bundle.main.path(forResource: "defaultThumbnail2", ofType: "png") ?? ""))
        
        var config = EVConfiguration(media: media)
        
//        config.isFullScreenModeSupported = false
//        config.progressBarMinimumTrackTintColor = .green
//        config.forwardSeekDuration = .k15
//        config.rewindSeekDuration = .k45
        config.shouldAutoPlay = true
//        config.fullScreenModeVideoGravity = .resize
//        config.isFullScreenShouldOpenWithLandscapeMode = true
//        config.shouldLoopVideo = true
//        config.videoGravity = .resizeAspect
        
        evPlayer.load(with: config)
    }
    
    @objc private func showEVPlayerControllerButtonTapped() {
        let media = EVMedia(videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,
                            thumbnailURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg"))
        
        var config = EVConfiguration(media: media)
        config.thumbnailContentMode = .scaleAspectFit
        config.videoGravity = .resizeAspect
        
        EVPlayerController.startFullScreenMode(withConfiguration: config)
    }
}

extension ViewController: EVPlayerDelegate {
        
    func evPlayer(stateDidChangedTo state: EVVideoState) {
        print("stateDidChanged", state)
    }
    
    func evPlayer(timeChangedTo currentTime: Double, totalTime: Double, loadedRange: Double) {
//        print("loadedRange ->", loadedRange)
    }
    
    func evPlayer(fullScreenTransactionUpdateTo state: EVFullScreenState) {
        print("stateDidChanged", state)
    }
}
