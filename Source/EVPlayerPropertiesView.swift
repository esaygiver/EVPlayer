//
//  EVPropertiesView.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 28.02.2023.
//

import UIKit
import AVKit

public class EVPlayerPropertiesView: UIStackView {
    
    lazy var videoSlider = EVSliderView(sliderType: .progress)
    private let currentVideoDurationLabel = UILabel()
    private let totalVideoDurationLabel = UILabel()

    // MARK: - Initializer
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        backgroundColor = .clear
        axis = .horizontal
        alignment = .fill
        distribution = .fill
        spacing = 8
        isUserInteractionEnabled = true
        
        currentVideoDurationLabel.font = UIFont.boldSystemFont(ofSize: 11)
        currentVideoDurationLabel.textColor = .white
        currentVideoDurationLabel.textAlignment = .center
        currentVideoDurationLabel.text = "--:--"
        currentVideoDurationLabel.widthAnchor.cuiSet(to: 35)
        
        totalVideoDurationLabel.font = UIFont.boldSystemFont(ofSize: 11)
        totalVideoDurationLabel.textColor = .white
        totalVideoDurationLabel.textAlignment = .center
        totalVideoDurationLabel.text = "--:--"
        totalVideoDurationLabel.widthAnchor.cuiSet(to: 35)
        
        addArrangedSubview(currentVideoDurationLabel)
        addArrangedSubview(videoSlider)
        addArrangedSubview(totalVideoDurationLabel)
    }
    
    func updateDuration(current: CMTime, total: CMTime) {
        DispatchQueue.main.async {
            self.videoSlider.value = Float(current.seconds / total.seconds)
            
            if let progressTimeStr = self.getConvertedStringFrom(current),
               let totalDurationStr = self.getConvertedStringFrom(total) {
                self.currentVideoDurationLabel.text = progressTimeStr
                self.totalVideoDurationLabel.text = totalDurationStr
            }
        }
    }
    
    private func getConvertedStringFrom(_ time: CMTime) -> String? {
        let totalSeconds = CMTimeGetSeconds(time)
        guard !(totalSeconds.isNaN || totalSeconds.isInfinite) else {
            return nil
        }
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60.0))
        let minutes = Int(totalSeconds / 60) % 60
        let hours = Int(totalSeconds / 3600)
        let hoursBiggerThan0Pattern = "%i:%02i:%02i"
        let hoursSmallerThan0Pattern = "%02i:%02i"
        
        if hours > 0 {
            currentVideoDurationLabel.widthAnchor.cuiSet(to: 50)
            totalVideoDurationLabel.widthAnchor.cuiSet(to: 50)
            return String(format: hoursBiggerThan0Pattern, [hours, minutes, seconds])
        }
        
        return String(format: hoursSmallerThan0Pattern, arguments: [minutes, seconds])
    }
}
