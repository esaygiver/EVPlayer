//
//  EVTapGestureOrganizer.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 17.03.2023.
//

import UIKit

public protocol EVTapGestureOrganizerImpl {
    typealias EVGestureEvent = (UITapGestureRecognizer) -> Void
    var singleTapGR: UITapGestureRecognizer { get }
    var doubleTapGR: UITapGestureRecognizer { get }
    var singleTapEvent: EVGestureEvent? { get set }
    var doubleTapEvent: EVGestureEvent? { get set }
}

public final class EVTapGestureOrganizer: EVTapGestureOrganizerImpl {
    
    // Gestures
    public lazy var singleTapGR = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
    public lazy var doubleTapGR = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
    
    public var singleTapEvent: ((UITapGestureRecognizer) -> Void)?
    public var doubleTapEvent: ((UITapGestureRecognizer) -> Void)?
    
    public init() {
        singleTapGR.numberOfTapsRequired = 1
        doubleTapGR.numberOfTapsRequired = 2
        singleTapGR.require(toFail: doubleTapGR)
    }
    
    @objc
    private func handleSingleTap(sender: UITapGestureRecognizer) {
        singleTapEvent?(sender)
    }
    
    @objc
    private func handleDoubleTap(sender: UITapGestureRecognizer) {
        doubleTapEvent?(sender)
    }
}
