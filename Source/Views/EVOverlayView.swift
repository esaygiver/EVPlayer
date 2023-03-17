//
//  EVOverlayView.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 15.03.2023.
//

import UIKit

enum EVOverlayType {
    case forward
    case rewind
    case none
    
    var image: UIImage? {
        switch self {
        case .forward:
            return Constants.Icons.overlayForwardImage
            
        case .rewind:
            return Constants.Icons.overlayRewindImage

        default:
            return nil
        }
    }
    
    var roundingCorners: CACornerMask {
        switch self {
        case .forward:
            return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            
        case .rewind:
            return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            
        default:
            return []
        }
    }
}

final class EVOverlayView: EVBaseView {
        
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = .white
        return imgView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let containerStack = UIStackView()
    
    private lazy var type: EVOverlayType = .none
    
    // MARK: - Initializer
    
    init(frame: CGRect = .zero, type: EVOverlayType) {
        super.init(frame: frame)
        self.type = type
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()

        backgroundColor = .clear
        imageView.image = type.image
        
        addSubview(containerStack)
        
        containerStack.axis = .vertical
        containerStack.alignment = .fill
        containerStack.distribution = .fillEqually
        containerStack.spacing = 0
        containerStack.isUserInteractionEnabled = true
        containerStack.addArrangedSubview(imageView)
        containerStack.addArrangedSubview(titleLabel)
    }
    
    override func setConstraints() {
        containerStack.cuiCenterVerticallyInSuperView(to: 5)
        containerStack.cuiCenterHorizontallyInSuperView(to: type == .forward ? 10 : -10)
        containerStack.widthAnchor.cuiSet(to: 75)
        containerStack.heightAnchor.cuiSet(to: 50)
    }
    
    func show(with animateDuration: Double = 0.75, seekDuration: Double) {
                
        titleLabel.text = (type == .forward ? "+" : "-") + String(format: "%.0f", seekDuration) + " " + "seconds"
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.containerStack.frame.origin.x = self.containerStack.frame.origin.x + (self.type == .forward ? -(self.frame.size.width / 2) : (self.frame.size.width / 2))
        })
        
        UIView.animate(withDuration: animateDuration, delay: 0.0, options: .curveEaseInOut, animations: {
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
