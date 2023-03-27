//
//  EVPlayerController.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 4.03.2023.
//

import UIKit
import AVKit

public class EVPlayerController: UIViewController {
    
    public typealias EVDefaultCallback = () -> Void
    public typealias EVConfigCallback = (EVConfiguration) -> Void

    private(set) var evFullScreenPlayer: EVFullScreenPlayer!
    private(set) var configuration: EVConfiguration?
    private let dismissButton = UIButton(type: .custom)
    
    private lazy var panGR = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler))
    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    
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
        EVDefaultLogger.logger.log("EVPlayerController", type: .deinited)
    }
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(panGR)
        view.backgroundColor = .black
        configureVideoView()
        configureDismissButton()
        
    }
    
    private func configureVideoView() {
        guard let config = configuration else {
            return
        }
        evFullScreenPlayer = EVFullScreenPlayer(frame: .zero)
        evFullScreenPlayer.reload(with: config)
        
        view.addSubview(evFullScreenPlayer)
        
        evFullScreenPlayer.cuiPinLeadingToSuperView()
        evFullScreenPlayer.cuiPinTrailingToSuperView()
        evFullScreenPlayer.cuiPinTopToSuperView(constant: 30)
        evFullScreenPlayer.cuiPinBottomToSuperView(constant: -30)
    }
    
    private func configureDismissButton() {
        evFullScreenPlayer.addSubview(dismissButton)
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
    public class func startFullScreenMode(
        withConfiguration config: EVConfiguration,
        presentCallback: EVDefaultCallback? = nil,
        willDismissCallback: EVConfigCallback? = nil,
        didDismissCallback: EVDefaultCallback? = nil) {
            
            guard let rootVC = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
                EVDefaultLogger.logger.error("\(#file), there is no root!")
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
    
    @objc
    private func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: view?.window)

        switch sender.state {
        case .began:
            initialTouchPoint = touchPoint
            
        case .changed:
            if touchPoint.y - initialTouchPoint.y > 0 {
                view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y,
                                    width: view.frame.size.width,
                                    height: view.frame.size.height)
            }
            
        case .ended,
                .cancelled:
            if touchPoint.y - initialTouchPoint.y > 150 {
                dismissScene()
                
            } else {
                UIView.animate(withDuration: 0.15, animations: {
                    self.view.frame = CGRect(x: 0, y: 0,
                                             width: self.view.frame.size.width,
                                             height: self.view.frame.size.height)
                })
            }
            
        default:
            break
        }
    }
}

// MARK: - Publish Config

extension EVPlayerController {
    
    private func willDismissWithConfig() {
        guard let player = evFullScreenPlayer.player else {
            return
        }
                
        let dismissContext = EVTransactionContext(seekTime: player.currentTime(),
                                                  isMuted: player.isMuted,
                                                  volume: player.volume)
        
        let dismissConfig = EVConfiguration(media: evFullScreenPlayer.configuration!.media,
                                            state: evFullScreenPlayer.videoState,
                                            context: dismissContext)
        
        /// To avoid audio clutter when dismiss transaction
        player.isMuted = true
        
        willDismissCallback?(dismissConfig)
    }
}
