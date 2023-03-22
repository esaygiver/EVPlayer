//
//  EVCoverView.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 28.02.2023.
//

import UIKit

protocol EVCoverViewDelegate: AnyObject {
    func play()
    func pause()
    func rewind(_ seconds: Double)
    func forward(_ seconds: Double)
    func volume(_ val: Float)
    func fullScreen()
    func restart()
}

public class EVCoverView: EVBaseView {
        
    // MARK: - UI Properties
    
    private let coverStack = UIStackView()
    private let volumeView = EVVolumeView()
    private let coverPlayButton = UIButton(type: .custom)
    private let fullScreenButton = UIButton(type: .custom)
    private let coverRewindButton = UIButton(type: .custom)
    private let coverForwardButton = UIButton(type: .custom)
    private let coverRestartButton = UIButton(type: .custom)
    private lazy var singleTapGR = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        
    weak var delegate: EVCoverViewDelegate?
    
    private(set) var isPlaying = true
    private(set) var forwardDuration: Double = 10
    private(set) var rewindDuration: Double = 10
    
    override func setup() {
        backgroundColor = .darkGray.withAlphaComponent(0.1)
        isHidden = true
        isUserInteractionEnabled = true
        
        singleTapGR.numberOfTapsRequired = 1
        addGestureRecognizer(singleTapGR)
        
        addSubview(coverStack)
        addSubview(volumeView)
        addSubview(fullScreenButton)
        
        coverPlayButton.tintColor = .white
        coverPlayButton.contentVerticalAlignment = .fill
        coverPlayButton.contentHorizontalAlignment = .fill
        coverPlayButton.setImage(Constants.Icons.pauseImage, for: .normal)
        coverPlayButton.setTitle("", for: .normal)
        coverPlayButton.backgroundColor = .clear
        coverPlayButton.adjustsImageWhenHighlighted = false
        coverPlayButton.addTarget(self, action: #selector(togglePlayingStatus), for: .touchUpInside)
        coverPlayButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        coverRewindButton.tintColor = .white
        coverRewindButton.contentVerticalAlignment = .fill
        coverRewindButton.contentHorizontalAlignment = .fill
        coverRewindButton.setImage(Constants.Icons.rewindImage10, for: .normal)
        coverRewindButton.setTitle("", for: .normal)
        coverRewindButton.backgroundColor = .clear
        coverRewindButton.adjustsImageWhenHighlighted = false
        coverRewindButton.addTarget(self, action: #selector(rewindEvent), for: .touchUpInside)
        
        coverForwardButton.tintColor = .white
        coverForwardButton.contentVerticalAlignment = .fill
        coverForwardButton.contentHorizontalAlignment = .fill
        coverForwardButton.setImage(Constants.Icons.forwardImage10, for: .normal)
        coverForwardButton.setTitle("", for: .normal)
        coverForwardButton.backgroundColor = .clear
        coverForwardButton.adjustsImageWhenHighlighted = false
        coverForwardButton.addTarget(self, action: #selector(forwardEvent), for: .touchUpInside)
        
        coverRestartButton.tintColor = .white
        coverRestartButton.contentVerticalAlignment = .fill
        coverRestartButton.contentHorizontalAlignment = .fill
        coverRestartButton.setImage(Constants.Icons.restartImage, for: .normal)
        coverRestartButton.setTitle("", for: .normal)
        coverRestartButton.backgroundColor = .clear
        coverRestartButton.adjustsImageWhenHighlighted = false
        coverRestartButton.addTarget(self, action: #selector(restartEvent), for: .touchUpInside)
        coverRestartButton.transform = CGAffineTransform(scaleX: 1.7, y: 1.6)
        coverRestartButton.isHidden = true
        
        coverStack.axis = .horizontal
        coverStack.alignment = .fill
        coverStack.distribution = .fillEqually
        coverStack.spacing = 30
        coverStack.isUserInteractionEnabled = true
        coverStack.addArrangedSubview(coverRewindButton)
        coverStack.addArrangedSubview(coverPlayButton)
        coverStack.addArrangedSubview(coverRestartButton)
        coverStack.addArrangedSubview(coverForwardButton)
        
        volumeView.delegate = self
        
        fullScreenButton.addTarget(self, action: #selector(fullScreen), for: .touchUpInside)
        fullScreenButton.setImage(Constants.Icons.fullScreenImage, for: .normal)
        fullScreenButton.tintColor = .white
        fullScreenButton.imageView?.contentMode = .scaleAspectFit
        fullScreenButton.contentVerticalAlignment = .fill
        fullScreenButton.contentHorizontalAlignment = .fill
        
        super.setup()
    }
    
    override func setConstraints() {
        coverStack.cuiCenterInSuperview()
        coverStack.widthAnchor.cuiSet(to: 135)
        coverStack.heightAnchor.cuiSet(to: 25)
        
        volumeView.cuiPinTrailingToSuperView(constant: -6)
        volumeView.cuiPinTopToSuperView(constant: 6)
        volumeView.widthAnchor.cuiSet(to: 85)
        volumeView.heightAnchor.cuiSet(to: 20)
        
        fullScreenButton.widthAnchor.cuiSet(to: 20)
        fullScreenButton.heightAnchor.cuiSet(to: 20)
        fullScreenButton.cuiPinTopToSuperView(constant: 6)
        fullScreenButton.cuiPinLeadingToSuperView(constant: 12)
    }
    
    func updateRewindButton(to state: EVSeekDuration) {
        rewindDuration = state.value
        coverRewindButton.setImage(state.rewindImage, for: .normal)
    }
    
    func updateForwardDuration(to state: EVSeekDuration) {
        forwardDuration = state.value
        coverForwardButton.setImage(state.forwardImage, for: .normal)
    }
    
    func updateVolumeUI(for volume: Float) {
        volumeView.changedValue(volume)
    }
    
    func hideFullScreenButton() {
        fullScreenButton.isHidden = true
    }
    
    func changePlayButtonImageForBufferState() {
        coverPlayButton.setImage(nil, for: .normal)
    }
    
    func changePlayButtonImageForLoadedState() {
        coverPlayButton.setImage(isPlaying ? Constants.Icons.pauseImage : Constants.Icons.playImage, for: .normal)
    }

    func notifyPlayerEnded() {
        visible()
        isPlaying = false
        coverPlayButton.isHidden = true
        coverRestartButton.isHidden = false
        coverRewindButton.isEnabled = false
        coverForwardButton.isEnabled = false
    }
    
    func notifyPlayerPlaying() {
        isPlaying = true
        coverPlayButton.isHidden = false
        coverRestartButton.isHidden = true
        coverRewindButton.isEnabled = true
        coverForwardButton.isEnabled = true
    }
        
    func notifyPlayerPause() {
        isPlaying = false
        coverRestartButton.isHidden = true
        coverPlayButton.isHidden = false
        coverRewindButton.isEnabled = true
        coverForwardButton.isEnabled = true
    }
}

// MARK: - @objc Events

extension EVCoverView {
    
    @objc
    private func togglePlayingStatus() {
        isPlaying.toggle()
        
        if isPlaying {
            delegate?.play()
            changePlayButtonImageToPauseWithAnimation()
        } else {
            delegate?.pause()
            changePlayButtonImageToPlayWithAnimation()
        }
    }
    
    @objc
    func rewindEvent() {
        tapAnimate(coverRewindButton)
        delegate?.rewind(rewindDuration)
    }
    
    @objc
    func forwardEvent() {
        tapAnimate(coverForwardButton)
        delegate?.forward(forwardDuration)
    }
    
    @objc
    private func fullScreen() {
        tapAnimate(fullScreenButton)
        delegate?.fullScreen()
    }
    
    @objc
    private func restartEvent() {
        isPlaying = true
        tapAnimate(coverRestartButton,
                   animationTransform: CGAffineTransform(scaleX: 1.3, y: 1.4),
                   afterAnimationTransform: CGAffineTransform(scaleX: 1.7, y: 1.6)) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.restart()
            strongSelf.hide()
        }
    }
    
    @objc
    func handleSingleTap() {
        hide()
    }
}

// MARK: - Visibility

extension EVCoverView {
    
    func toggleVisibility() {
        isHidden ? visible() : hide()
    }
    
    func visible() {
        let cachedFullScreenOriginY = fullScreenButton.frame.origin.y
        fullScreenButton.frame.origin.y = 0
        
        let cachedVolumeViewOriginY = volumeView.frame.origin.y
        volumeView.frame.origin.y = 0
        
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseInOut, animations: {
            self.fullScreenButton.frame.origin.y = cachedFullScreenOriginY
            self.volumeView.frame.origin.y = cachedVolumeViewOriginY
        })
        
        isHidden = false
    }
    
    func hide() {
        UIView.animate(withDuration: 0.35, animations: {
            self.alpha = 0.0
        }) { _ in
            self.isHidden = true
            self.alpha = 1.0
        }
    }
}

// MARK: - Animation

private extension EVCoverView {
    
    func changePlayButtonImageToPauseWithAnimation() {
        UIView.animate(withDuration: 0.1, animations: {
            self.coverPlayButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                self.coverPlayButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.coverPlayButton.setImage(Constants.Icons.pauseImage, for: .normal)
            }) { _ in
                self.hide()
            }
        }
    }
    
    func changePlayButtonImageToPlayWithAnimation() {
        UIView.animate(withDuration: 0.1, animations: {
            self.coverPlayButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                self.coverPlayButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.coverPlayButton.setImage(Constants.Icons.playImage, for: .normal)
            })
        }
    }
    
    func tapAnimate(_ sender: UIButton,
                    animationTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.9, y: 0.9),
                    afterAnimationTransform: CGAffineTransform? = nil,
                    completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = animationTransform
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = afterAnimationTransform ?? .identity
            }) { _ in
                completion?()
            }
        }
    }
}

// MARK: - Implementation of EVVolumeViewDelegate

extension EVCoverView: EVVolumeViewDelegate {
    
    func volumeChangedTo(_ val: Float) {
        delegate?.volume(val)
    }
}

extension EVCoverView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == coverStack {
            return false
        }
        return true
    }
}
