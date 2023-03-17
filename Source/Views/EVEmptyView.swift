//
//  EVEmptyView.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 13.03.2023.
//

import UIKit

final class EVEmptyView: EVBaseView {
        
    private let emptyImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = Constants.Icons.notAvailablePlayingImage
        imgView.tintColor = .white
        return imgView
    }()

    override func setup() {
        addSubview(emptyImageView)
        super.setup()
    }
    
    override func setConstraints() {
        emptyImageView.widthAnchor.cuiSet(to: 50)
        emptyImageView.heightAnchor.cuiSet(to: 50)
        emptyImageView.cuiCenterInSuperview()
    }
}
