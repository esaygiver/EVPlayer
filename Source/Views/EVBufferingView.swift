//
//  EVBufferingView.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 28.02.2023.
//

import UIKit

public class EVBufferingView: EVBaseView {
    
    private lazy var progressView: UIActivityIndicatorView = {
        let prgView = UIActivityIndicatorView()
        prgView.color = .white
        prgView.backgroundColor = .clear
        prgView.hidesWhenStopped = true
        prgView.layer.cornerRadius = 12
        if #available(iOS 13.0, *) {
            prgView.style = .medium
        } else {
            prgView.style = .gray
        }
        return prgView
    }()
    
    override func setup() {
        backgroundColor = .clear
        addSubview(progressView)
        super.setup()
    }
    
    override func setConstraints() {
        progressView.cuiCenterInSuperview()
        progressView.heightAnchor.cuiSet(to: 40)
        progressView.widthAnchor.cuiSet(to: 40)
    }

    func show() {
        isHidden = false
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hide(_ completion: (() -> Void)? = nil) {
        isHidden = true
        progressView.stopAnimating()
        completion?()
    }
}
