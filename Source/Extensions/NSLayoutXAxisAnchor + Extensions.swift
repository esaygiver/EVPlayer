//
//  NSLayoutXAxisAnchor + Extensions.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 25.02.2023.
//

import UIKit

public extension NSLayoutXAxisAnchor {

    /// Docks anchor to another one
    ///
    /// - Parameters:
    ///   - anchor: Anchor to be dock
    ///   - constant: Constant to be applied (defaults to 0)
    ///   - priority: Priority of the constraint (defaults to required)
    /// - Returns: Already activated NSLayoutConstraint instance
    /// - Example: view1.leadingAnchor.cuiDock(to: view2.trailingAnchor, constant: CGFloat(30.0))
    @discardableResult
    func cuiDock(
        to anchor: NSLayoutXAxisAnchor,
        constant: CGFloat = CGFloat(0),
        priority: UILayoutPriority = .required
        ) -> NSLayoutConstraint {

        let cons = constraint(equalTo: anchor, constant: constant)
        cons.priority = priority
        cons.isActive = true
        return cons
    }
}

public extension NSLayoutYAxisAnchor {

    /// Docks anchor to another one
    ///
    /// - Parameters:
    ///   - anchor: Anchor to be dock
    ///   - constant: Constant to be applied (defaults to 0)
    ///   - priority: Priority of the constraint (defaults to required)
    /// - Returns: Already activated NSLayoutConstraint instance
    /// - Example: view1.bottomAnchor.cuiDock(to: view2.bottomAnchor, constant: CGFloat(30.0))
    @discardableResult
    func cuiDock(
        to anchor: NSLayoutYAxisAnchor,
        constant: CGFloat = CGFloat(0),
        priority: UILayoutPriority = .required
        ) -> NSLayoutConstraint {

        let cons = constraint(equalTo: anchor, constant: constant)
        cons.priority = priority
        cons.isActive = true
        return cons
    }
}
