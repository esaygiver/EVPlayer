//
//  ViewController.swift
//  EVPlayer
//
//  Created by esaygiver on 03/16/2023.
//  Copyright (c) 2023 esaygiver. All rights reserved.
//

import UIKit
import AVKit
import EVPlayer

class ViewController: UIViewController {

    var evPlayer: EVPlayer!
    
    let media = EVMedia(mediaURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"),
                        thumbnailURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg"))

    override func viewDidLoad() {
        super.viewDidLoad()

        configureEVPlayer()
    }
    
    private func configureEVPlayer() {
        evPlayer = EVPlayer(frame: CGRect(x: 0, y: 0, width: 350, height: 200))

        view.addSubview(evPlayer)
        evPlayer.delegate = self
        evPlayer.center = view.center
        
        var config = EVConfiguration(media: media,
                                     initialState: .quickPlay)
        evPlayer.load(with: config)
    }
}

extension ViewController: EVPlayerDelegate {

    func stateDidChanged(player: AVPlayer?, to state: EVVideoState) {
        print("stateDidChanged", state)
    }
    
    func playTimeDidChanged(player: AVPlayer?, currentTime: Double, totalTime: Double, loadedRange: String) {
//        print("DOWNLOADED -> %", loadedRange)
    }
    
    func fullScreenTransactionUpdate(to state: EVFullScreenState) {
        print("Current FullScreen State:", state)
    }
}

