//
//  EVThumbnailView.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 22.02.2023.
//

import UIKit

protocol EVThumbnailViewDelegate: AnyObject {
    func start()
}

public class EVThumbnailView: EVBaseView {
        
    // MARK: - UI Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let alphaView: UIView = {
        let view = UIView()
        view.alpha = 0.15
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var centeredButton: UIButton = {
        let button = UIButton(type: .custom)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setImage(Constants.Icons.thumbnailPlayImage, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(thumbnailButtonEvent), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: EVThumbnailViewDelegate?
    
    override func setup() {
        backgroundColor = .black
        addSubview(imageView)
        addSubview(alphaView)
        addSubview(centeredButton)
        super.setup()
    }
    
    override func setConstraints() {
        centeredButton.cuiCenterInSuperview()
        centeredButton.heightAnchor.cuiSet(to: 60)
        centeredButton.widthAnchor.cuiSet(to: 60)
        
        imageView.cuiPinToSuperview()
        
        alphaView.cuiPinToSuperview()
    }
    
    func makePlayButtonHidden() {
        centeredButton.isHidden = true
    }
    
    func updateThumbnailImage(to url: URL?, contentMode: UIView.ContentMode = .scaleToFill) {
        imageView.contentMode = contentMode
        downloadThumbnailImage(from: url)
    }
    
    private func downloadThumbnailImage(from url: URL?) {
        guard let url = url else {
            EVDefaultLogger.logger.error("\(#function), thumbnail url is nil!")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                EVDefaultLogger.logger.error(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                EVDefaultLogger.logger.error("\(#file), data is nil for \(url.absoluteString)")
                return
            }
            
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
            
        }.resume()
    }
    
    @objc
    private func thumbnailButtonEvent() {
        UIView.animate(withDuration: 0.2, animations: {
            self.centeredButton.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            
        }) { _ in
            self.delegate?.start()
            self.centeredButton.isHidden = true
            self.centeredButton.transform = CGAffineTransform.identity
        }
    }
}
