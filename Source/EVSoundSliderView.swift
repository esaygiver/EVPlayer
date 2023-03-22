//
//  EVSoundSliderView.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 20.03.2023.
//

import Foundation

protocol EVSoundSliderViewDelegate: AnyObject {
    func changedValue(_ val: Float)
}

final class EVSoundSliderView: EVSliderView {
    
    weak var delegate: EVSoundSliderViewDelegate?
    
    override func setup() {
        isContinuous = true
        value = 1.0
        minimumTrackTintColor = .white
        maximumTrackTintColor = .lightGray.withAlphaComponent(0.8)
        thumbTintColor = .clear
        addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
        setThumbImage(makeSliderImage(size: CGSize(width: 4, height: 4)), for: .normal)
        setThumbImage(makeSliderImage(size: CGSize(width: 4, height: 4)), for: .highlighted)
        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.2)
        
        super.setup()
    }
    
    @objc
    func sliderValueChanged(_ sender: UISlider) {
        
        delegate?.changedValue(sender.value)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 2.2)
        })
        
        if isTracking {
            changeSliderUI(value: sender.value)
        }
    }
    
    @objc
    private func touchUpInside(_ sender: UISlider) {
        guard !sender.isTracking else {
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.2)
        })
    }
    
    func changeSliderUI(value: Float) {
        if value >= 0.9 {
            setThumbImage(makeSliderImage(size: CGSize(width: 4, height: 4)), for: .normal)
            setThumbImage(makeSliderImage(size: CGSize(width: 4, height: 4)), for: .highlighted)
            return
        }
        setThumbImage(UIImage(), for: .normal)
        setThumbImage(UIImage(), for: .highlighted)

    }
}
