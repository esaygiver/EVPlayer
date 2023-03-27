//
//  MockEVBufferingView.swift
//  EVPlayer_Tests
//
//  Created by Emirhan Saygiver on 27.03.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import EVPlayer

final class MockEVBufferingView: EVBufferingViewType {
        
    var isBufferingInterfaceVisible = false
    
    func show() {
        isBufferingInterfaceVisible = true
    }

    func hide(_ completion: @escaping (() -> Void)) {
        isBufferingInterfaceVisible = false
        completion()
    }
}
