//
//  EVFullScreenPlayer.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 6.03.2023.
//

import UIKit

public class EVFullScreenPlayer: EVPlayer {
    
    // MARK: - Initializer
    
    override init(frame: CGRect,
                  interfaceImpl: EVPlayerInterfaceImplementation = EVPlayerInterfaceApplier()) {
        super.init(frame: frame)
        applyFullScreenUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        prepareForReuse()
    }
    
    func reload(with config: EVConfiguration) {
        load(with: config)
        applyConfiguration(config)
        seek(to: config.seekTime)
    }
    
    func applyFullScreenUI() {
        if let coverView = coverInterface as? EVCoverView {
            coverView.backgroundColor = .clear
            coverView.hideFullScreenButton()
        }
    }
}
