//
//  EVBaseView.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 15.03.2023.
//

import UIKit

open class EVBaseView: UIView {
    
    // MARK: - Initializer
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        setConstraints()
    }
    
    func setConstraints() { }
}
