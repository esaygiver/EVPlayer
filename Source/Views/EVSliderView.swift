//
//  EasyVideoSlider.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 22.02.2023.
//

import UIKit

enum EVSliderType {
    case progress
    case sound
    case none
}

protocol EVSliderViewDelegate: AnyObject {
    func changedValue(_ val: Float)
}

final class EVSliderView: UISlider {
    
    weak var delegate: EVSliderViewDelegate?
    var sliderType: EVSliderType = .none
        
    // MARK: - Initializer
    
    init(frame: CGRect = .zero, sliderType: EVSliderType) {
        self.sliderType = sliderType
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {

        translatesAutoresizingMaskIntoConstraints = false
        maximumTrackTintColor = .lightGray.withAlphaComponent(0.8)

        switch sliderType {
        case .progress:
            isContinuous = false
            value = 0
            thumbTintColor = .white
            minimumTrackTintColor = .orange
            addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
            addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
            setThumbImage(makeSliderImage(size: CGSize(width: 14, height: 14)), for: .normal)
            setThumbImage(makeSliderImage(size: CGSize(width: 18, height: 18)), for: .highlighted)
            
        case .sound:
            isContinuous = true
            value = 1.0
            minimumTrackTintColor = .white
            thumbTintColor = .clear
            setThumbImage(makeSliderImage(size: CGSize(width: 4, height: 4)), for: .normal)
            setThumbImage(makeSliderImage(size: CGSize(width: 4, height: 4)), for: .highlighted)
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.2)

        case .none:
            break
        }
    }
    
    @objc
    func sliderValueChanged(_ sender: UISlider) {
        guard sliderType == .sound else {
            return
        }
        
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
        guard sliderType == .sound && !sender.isTracking else {
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.2)
        })
    }
    
    func changeSliderUI(value: Float) {
        if value != 0.0 {
            setThumbImage(makeSliderImage(size: CGSize(width: 4, height: 4)), for: .normal)
            setThumbImage(makeSliderImage(size: CGSize(width: 4, height: 4)), for: .highlighted)

        } else {
            setThumbImage(UIImage(), for: .normal)
            setThumbImage(UIImage(), for: .highlighted)
        }
    }
    
    private func makeSliderImage(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        let bounds = CGRect(origin: .zero, size: size)
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
