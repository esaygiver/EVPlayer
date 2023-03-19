//
//  NavigationChangeAdapter.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 17.03.2023.
//

import Foundation

/** Example Usage:
    XViewController owns EVPlayer property and want to change navigation,
    you can use it like changeStateForNavigationChanges(to: pause) before transaction.
    And also, back to your XViewController, in viewWillApper you may call changeStateForNavigationChanges(to: play)
    it will continue from last pause time.
*/

/// Use this protocol for changing EVPlayer state, when trying to change top UIViewController on view hierarchy.
public protocol EVNavigationAdapter {
    func changeStateForNavigationChanges(to state: EVVideoState)
}

extension EVNavigationAdapter where Self: EVPlayer {
    
    public func changeStateForNavigationChanges(to state: EVVideoState) {
        updateState(to: state)
    }
}
