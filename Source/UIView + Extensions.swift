//
//  UIView + Extensions.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 25.02.2023.
//

import UIKit

// MARK: - Autolayout Helpers

public extension UIView {

    /// Pins view to superview
    ///
    /// - Parameters:
    ///   - insets: Edge insets (defaults to .zero)
    ///   - shouldRespectSafeArea: Whether safe area should be respected or not (defaults to true)
    /// - Returns: Added layout constraints array. In leading, trailing, top, bottom order
    /// - Example: view.cuiPinToSuperView(with: UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0))
    /// - Warning: Uses insets.left for leading and insets.right for trailing everytime (even layout direction is right to left)
    @discardableResult
    func cuiPinToSuperview(
        with insets: UIEdgeInsets = .zero,
        shouldRespectSafeArea: Bool = true
        ) -> [NSLayoutConstraint] {

        guard superview != nil else {
            return []
        }

        var constraints: [NSLayoutConstraint] = []

        if let leading = cuiPinLeadingToSuperView(
            constant: insets.left,
            shouldRespectSafeArea: shouldRespectSafeArea
            ) {

            constraints.append(leading)
        }

        if let trailing = cuiPinTrailingToSuperView(
            constant: insets.right,
            shouldRespectSafeArea: shouldRespectSafeArea
            ) {
            constraints.append(trailing)
        }

        if let top = cuiPinTopToSuperView(
            constant: insets.top,
            shouldRespectSafeArea: shouldRespectSafeArea
            ) {
            constraints.append(top)
        }

        if let bottom = cuiPinBottomToSuperView(
            constant: insets.bottom,
            shouldRespectSafeArea: shouldRespectSafeArea
            ) {
            constraints.append(bottom)
        }

        return constraints
    }

    /// Pins leading anchor to superview's leading anchor
    ///
    /// - Parameters:
    ///   - constant: Constant to be applied between anchors
    ///   - shouldRespectSafeArea: Whether safe area should be respected or not (defaults to true)
    /// - Returns: Already activated `NSLayoutConstraint` instance or nil if view has no superview
    @discardableResult
    func cuiPinLeadingToSuperView(
        constant: CGFloat = 0.0,
        shouldRespectSafeArea: Bool = true
        ) -> NSLayoutConstraint? {

        guard let superview = superview else {
            return nil
        }

        translatesAutoresizingMaskIntoConstraints = false

        guard #available(iOS 11.0, *),
            superview.responds(to: #selector(getter: safeAreaLayoutGuide)) else {

                return leadingAnchor.cuiDock(
                    to: superview.leadingAnchor,
                    constant: constant
                )
        }

        return leadingAnchor.cuiDock(
            to: shouldRespectSafeArea ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor,
            constant: constant
        )
    }

    /// Pins trailing anchor to superview's trailing anchor
    ///
    /// - Parameters:
    ///   - constant: Constant to be applied between anchors
    ///   - shouldRespectSafeArea: Whether safe area should be respected or not (defaults to true)
    /// - Returns: Already activated `NSLayoutConstraint` instance or nil if view has no superview
    @discardableResult
    func cuiPinTrailingToSuperView(
        constant: CGFloat = 0.0,
        shouldRespectSafeArea: Bool = true
        ) -> NSLayoutConstraint? {

        guard let superview = superview else {
            return nil
        }

        translatesAutoresizingMaskIntoConstraints = false

        guard #available(iOS 11.0, *),
            superview.responds(to: #selector(getter: safeAreaLayoutGuide)) else {

                return trailingAnchor.cuiDock(
                    to: superview.trailingAnchor,
                    constant: constant
                )
        }

        return trailingAnchor.cuiDock(
            to: shouldRespectSafeArea ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor,
            constant: constant
        )
    }

    /// Pins top anchor to superview's top anchor
    ///
    /// - Parameters:
    ///   - constant: Constant to be applied between anchors
    ///   - shouldRespectSafeArea: Whether safe area should be respected or not (defaults to true)
    /// - Returns: Already activated `NSLayoutConstraint` instance or nil if view has no superview
    @discardableResult
    func cuiPinTopToSuperView(
        constant: CGFloat = 0.0,
        shouldRespectSafeArea: Bool = true
        ) -> NSLayoutConstraint? {

        guard let superview = superview else {
            return nil
        }

        translatesAutoresizingMaskIntoConstraints = false

        guard #available(iOS 11.0, *),
            superview.responds(to: #selector(getter: safeAreaLayoutGuide)) else {

                return topAnchor.cuiDock(
                    to: superview.topAnchor,
                    constant: constant
                )
        }

        return topAnchor.cuiDock(
            to: shouldRespectSafeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor,
            constant: constant
        )
    }

    /// Pins bottom anchor to superview's bottom anchor
    ///
    /// - Parameters:
    ///   - constant: Constant to be applied between anchors
    ///   - shouldRespectSafeArea: Whether safe area should be respected or not (defaults to true)
    /// - Returns: Already activated `NSLayoutConstraint` instance or nil if view has no superview
    @discardableResult
    func cuiPinBottomToSuperView(
        constant: CGFloat = 0.0,
        shouldRespectSafeArea: Bool = true
        ) -> NSLayoutConstraint? {

        guard let superview = superview else {
            return nil
        }

        translatesAutoresizingMaskIntoConstraints = false

        guard #available(iOS 11.0, *),
            superview.responds(to: #selector(getter: safeAreaLayoutGuide)) else {

                return bottomAnchor.cuiDock(
                    to: superview.bottomAnchor,
                    constant: constant
                )
        }

        return bottomAnchor.cuiDock(
            to: shouldRespectSafeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor,
            constant: constant
        )
    }

    /// Centers view in superview
    ///
    /// - Returns: Added layout constraints array (centerX, centerY order) or nil if it has no superview
    /// - Example: view.cuiCenterInSuperView()
    @discardableResult
    func cuiCenterInSuperview() -> [NSLayoutConstraint] {

        var constraints: [NSLayoutConstraint] = []

        if let centerXConstraint = cuiCenterHorizontallyInSuperView() {
            constraints.append(centerXConstraint)
        }

        if let centerYConstraint = cuiCenterVerticallyInSuperView() {
            constraints.append(centerYConstraint)
        }

        return constraints
    }

    /// Centers view horizontally in superview
    ///
    /// - Returns: Added layout constraint or nil if it has no superview
    /// - Example: view.cuiCenterHorizontallyInSuperView
    @discardableResult
    func cuiCenterHorizontallyInSuperView(to constant: CGFloat = 0.0) -> NSLayoutConstraint? {

        guard let superview = superview else {
            return nil
        }

        translatesAutoresizingMaskIntoConstraints = false

        return centerXAnchor.cuiDock(to: superview.centerXAnchor, constant: constant)
    }

    /// Centers view veritcally in superview
    ///
    /// - Returns: Added layout constraint or nil if it has no superview
    /// - Example: view.cuiCenterVerticallyInSuperView
    @discardableResult
    func cuiCenterVerticallyInSuperView(to constant: CGFloat = 0.0) -> NSLayoutConstraint? {

        guard let superview = superview else {
            return nil
        }

        translatesAutoresizingMaskIntoConstraints = false

        return centerYAnchor.cuiDock(to: superview.centerYAnchor, constant: constant)
    }
}

public extension NSLayoutDimension {
    
    /// Sets dimension to a constant value
    func cuiSet(to constant: CGFloat) {
        let cons = constraint(equalToConstant: constant)
        cons.isActive = true
    }
}
