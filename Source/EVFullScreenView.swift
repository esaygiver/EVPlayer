//
//  EVFullScreenView.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 6.03.2023.
//

import UIKit

open class EVFullScreenView: EVPlayer {
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
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
        coverView.backgroundColor = .clear
        coverView.hideFullScreenButton()
    }
}
