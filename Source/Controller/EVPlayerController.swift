//
//  EVPlayerController.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 4.03.2023.
//

import UIKit
import AVKit

public class EVPlayerController: UIViewController {
    
    typealias EVDefaultCallback = () -> Void
    typealias EVConfigCallback = (EVConfiguration) -> Void

    private(set) var videoContainerView: EVFullScreenView!
    private(set) var configuration: EVConfiguration?
    private let dismissButton = UIButton(type: .custom)
    
    private(set) var willDismiss = false
    private var willDismissCallback: EVConfigCallback?
    private var didDismissCallback: EVDefaultCallback?
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let configuration = configuration else {
            return .allButUpsideDown
        }
        return configuration.isFullScreenShouldOpenWithLandscapeMode ? .landscape : configuration.fullScreenSupportedInterfaceOrientations
    }

    public override var shouldAutorotate: Bool {
        guard let configuration = configuration else {
            return false
        }
        return configuration.isFullScreenShouldAutoRotate
    }
    
    // MARK: - Initializer
    
    init(configuration: EVConfiguration) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        EVViewDefaultLogger.logger.log("EVPlayerController", type: .deinited)
    }
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureVideoView()
        configureDismissButton()
    }
    
    private func configureVideoView() {
        guard let config = configuration else {
            return
        }
        videoContainerView = EVFullScreenView()
        videoContainerView.reload(with: config)
        
        view.addSubview(videoContainerView)
        
        videoContainerView.cuiPinLeadingToSuperView()
        videoContainerView.cuiPinTrailingToSuperView()
        videoContainerView.cuiPinTopToSuperView(constant: 30)
        videoContainerView.cuiPinBottomToSuperView(constant: -30)
    }
    
    private func configureDismissButton() {
        videoContainerView.addSubview(dismissButton)
        dismissButton.addTarget(self, action: #selector(dismissScene), for: .touchUpInside)
        dismissButton.setImage(Constants.Icons.dismissImage, for: .normal)
        dismissButton.tintColor = .white
        dismissButton.imageView?.contentMode = .scaleAspectFit
        dismissButton.contentVerticalAlignment = .fill
        dismissButton.contentHorizontalAlignment = .fill
        
        dismissButton.widthAnchor.cuiSet(to: 20)
        dismissButton.heightAnchor.cuiSet(to: 20)
        dismissButton.cuiPinTopToSuperView(constant: 6)
        dismissButton.cuiPinLeadingToSuperView(constant: 12)
    }
    
    /// Presents EVPlayerController with EVConfiguration
    /// - Parameters:
    ///   - configuration: Customizable EVConfiguration
    ///   - presentCallback: After presentation callback
    class func show(
        withConfiguration config: EVConfiguration,
        presentCallback: EVDefaultCallback? = nil,
        willDismissCallback: EVConfigCallback? = nil,
        didDismissCallback: EVDefaultCallback? = nil) {
            
            guard let rootVC = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
                EVViewDefaultLogger.logger.error("\(#file), there is no root!")
                return
            }
            
            let eVController = EVPlayerController(configuration: config)
            
            eVController.modalPresentationStyle = config.fullScreenPresentationStyle
            eVController.willDismissCallback = willDismissCallback
            eVController.didDismissCallback = didDismissCallback
            
            rootVC.present(eVController,
                           animated: config.isTransactionAnimated,
                           completion: presentCallback)
        }
    
    @objc
    private func dismissScene() {
        willDismissWithConfig()
    
        dismiss(animated: true) { [weak self] in
            self?.didDismissCallback?()
        }
    }
}

// MARK: - Publish Config

extension EVPlayerController {
    
    private func willDismissWithConfig() {
        guard let player = videoContainerView.player else {
            return
        }
        
        willDismiss = true
        
        let dismissConfig = EVConfiguration(initialState: videoContainerView.videoState,
                                            seekTime: player.currentTime(),
                                            isMuted: player.isMuted,
                                            volume: player.volume)
        willDismissCallback?(dismissConfig)
    }
}
