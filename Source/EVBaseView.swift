//
//  EVBaseView.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 15.03.2023.
//

import UIKit

public class EVBaseView: UIView {
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        setConstraints()
    }
    
    func setConstraints() { }
}
