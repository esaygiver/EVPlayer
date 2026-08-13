//
//  EVVolumeView.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 3.03.2023.
//

import UIKit

protocol EVVolumeViewDelegate: AnyObject {
    func volumeChangedTo(_ val: Float)
}

final class EVVolumeView: EVBaseView {
    
    private lazy var soundSlider = EVSoundSliderView()
    private lazy var soundButton = UIButton(type: .custom)
    
    weak var delegate: EVVolumeViewDelegate?
    private(set) var isSoundOpen = true
    
    override func setup() {
        updateSoundButtonImage(Constants.Icons.soundOnImage)
        soundButton.tintColor = .white
        soundButton.contentVerticalAlignment = .fill
        soundButton.contentHorizontalAlignment = .fill
        soundButton.setTitle("", for: .normal)
        soundButton.backgroundColor = .clear
        soundButton.addTarget(self, action: #selector(switchSoundState), for: .touchUpInside)
        
        soundSlider.delegate = self
        
        addSubview(soundButton)
        addSubview(soundSlider)
        
        super.setup()
    }
    
    override func setConstraints() {
        soundButton.cuiPinTopToSuperView()
        soundButton.cuiPinTrailingToSuperView()
        soundButton.cuiPinBottomToSuperView()
        soundButton.widthAnchor.cuiSet(to: 20)
        
        soundSlider.cuiPinBottomToSuperView()
        soundSlider.cuiPinTopToSuperView(constant: -1)
        soundSlider.cuiPinLeadingToSuperView()
        soundSlider.trailingAnchor.cuiDock(to: soundButton.leadingAnchor, constant: -5)
    }
    
    @objc func switchSoundState() {
        isSoundOpen.toggle()
        
        UIView.animate(withDuration: 0.1, animations: {
            self.soundButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                self.soundButton.transform = CGAffineTransform.identity
            })
        }
        
        if isSoundOpen {
            updateSoundButtonImage(Constants.Icons.soundOnImage)
            soundSlider.value = 1.0
            changedValue(1.0)
        } else {
            updateSoundButtonImage(Constants.Icons.soundOffImage)
            soundSlider.value = 0.0
            changedValue(0.0)
        }
    }

    private func updateSoundButtonImage(_ image: UIImage?) {
        soundButton.setImage(image, for: .normal)
        soundButton.setImage(image, for: .highlighted)
    }
}

// MARK: - Implementation of EVSoundSliderViewDelegate

extension EVVolumeView: EVSoundSliderViewDelegate {

    func changedValue(_ val: Float) {
        soundSlider.value = val
        isSoundOpen = val != 0
        soundSlider.changeSliderUI(value: val)
        updateSoundButtonImage(isSoundOpen ? Constants.Icons.soundOnImage : Constants.Icons.soundOffImage)
        delegate?.volumeChangedTo(val)
    }
}
