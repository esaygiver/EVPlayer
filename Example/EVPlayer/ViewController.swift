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

    @IBOutlet private weak var goButton: UIButton!
    
    var evPlayer: EVPlayer!
    
    let media = EVMedia(mediaURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"),
                        thumbnailURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg"))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        configureEVPlayer()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        evPlayer.changeStateForNavigationChanges(to: .play)
//    }
    
    private func configureEVPlayer() {
        evPlayer = EVPlayer(frame: CGRect(x: 0, y: 0, width: 350, height: 200))

        view.addSubview(evPlayer)
        evPlayer.delegate = self
        evPlayer.center = view.center
        
        var config = EVConfiguration(media: media)
        config.shouldAutoPlay = true
        config.isFullScreenShouldOpenWithLandscapeMode = true
//        config.shouldLoopVideo = true
        evPlayer.load(with: config)
    }
    
    @IBAction private func goTapped() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        evPlayer.changeStateForNavigationChanges(to: .pause)
        navigationController?.pushViewController(vc, animated: true)
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

