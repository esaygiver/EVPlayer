//
//  EVPlayer + Constants.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 25.02.2023.
//

import UIKit

final class Constants {

    enum Icons {
        static let pauseImage               = image(named: "pause.fill")
        static let playImage                = image(named: "play.fill")
        static let thumbnailPlayImage       = image(named: "play.circle.fill")
        static let rewindImage5             = image(named: "gobackward.5")
        static let rewindImage10            = image(named: "gobackward.10")
        static let rewindImage15            = image(named: "gobackward.15")
        static let rewindImage30            = image(named: "gobackward.30")
        static let rewindImage45            = image(named: "gobackward.45")
        static let rewindImage60            = image(named: "gobackward.60")
        static let rewindImage75            = image(named: "gobackward.75")
        static let rewindImage90            = image(named: "gobackward.90")
        static let forwardImage5            = image(named: "goforward.5")
        static let forwardImage10           = image(named: "goforward.10")
        static let forwardImage15           = image(named: "goforward.15")
        static let forwardImage30           = image(named: "goforward.30")
        static let forwardImage45           = image(named: "goforward.45")
        static let forwardImage60           = image(named: "goforward.60")
        static let forwardImage75           = image(named: "goforward.75")
        static let forwardImage90           = image(named: "goforward.90")
        static let restartImage             = image(named: "memories")
        static let soundOffImage            = image(named: "player_mute")
        static let soundOnImage             = image(named: "player_unmute")
        static let fullScreenImage          = image(named: "rectangle.expand.vertical")
        static let dismissImage             = image(named: "xmark")
        static let notAvailablePlayingImage = image(named: "play.slash")
        static let overlayForwardImage      = image(named: "forward.fill")
        static let overlayRewindImage       = image(named: "backward.fill")

        private static var resourceBundle: Bundle {
            #if SWIFT_PACKAGE
            return .module
            #else
            return Bundle(for: Constants.self)
            #endif
        }

        private static func image(named name: String) -> UIImage? {
            UIImage(named: name, in: resourceBundle, compatibleWith: nil)
        }
    }
}
