//
//  EVPlayer + Constants.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 25.02.2023.
//

import UIKit

final class Constants {

    enum Icons {
        static let pauseImage               = UIImage(named: "pause.fill",                  in: Bundle(for: Constants.self), compatibleWith: nil)
        static let playImage                = UIImage(named: "play.fill",                   in: Bundle(for: Constants.self), compatibleWith: nil)
        static let thumbnailPlayImage       = UIImage(named: "play.circle.fill",            in: Bundle(for: Constants.self), compatibleWith: nil)
        static let rewindImage5             = UIImage(named: "gobackward.5",                in: Bundle(for: Constants.self), compatibleWith: nil)
        static let rewindImage10            = UIImage(named: "gobackward.10",               in: Bundle(for: Constants.self), compatibleWith: nil)
        static let rewindImage15            = UIImage(named: "gobackward.15",               in: Bundle(for: Constants.self), compatibleWith: nil)
        static let rewindImage30            = UIImage(named: "gobackward.30",               in: Bundle(for: Constants.self), compatibleWith: nil)
        static let rewindImage45            = UIImage(named: "gobackward.45",               in: Bundle(for: Constants.self), compatibleWith: nil)
        static let rewindImage60            = UIImage(named: "gobackward.60",               in: Bundle(for: Constants.self), compatibleWith: nil)
        static let rewindImage75            = UIImage(named: "gobackward.75",               in: Bundle(for: Constants.self), compatibleWith: nil)
        static let rewindImage90            = UIImage(named: "gobackward.90",               in: Bundle(for: Constants.self), compatibleWith: nil)
        static let forwardImage5            = UIImage(named: "goforward.5",                 in: Bundle(for: Constants.self), compatibleWith: nil)
        static let forwardImage10           = UIImage(named: "goforward.10",                in: Bundle(for: Constants.self), compatibleWith: nil)
        static let forwardImage15           = UIImage(named: "goforward.15",                in: Bundle(for: Constants.self), compatibleWith: nil)
        static let forwardImage30           = UIImage(named: "goforward.30",                in: Bundle(for: Constants.self), compatibleWith: nil)
        static let forwardImage45           = UIImage(named: "goforward.45",                in: Bundle(for: Constants.self), compatibleWith: nil)
        static let forwardImage60           = UIImage(named: "goforward.60",                in: Bundle(for: Constants.self), compatibleWith: nil)
        static let forwardImage75           = UIImage(named: "goforward.75",                in: Bundle(for: Constants.self), compatibleWith: nil)
        static let forwardImage90           = UIImage(named: "goforward.90",                in: Bundle(for: Constants.self), compatibleWith: nil)
        static let restartImage             = UIImage(named: "memories",                    in: Bundle(for: Constants.self), compatibleWith: nil)
        static let soundOffImage            = UIImage(named: "player_mute",                 in: Bundle(for: Constants.self), compatibleWith: nil)
        static let soundOnImage             = UIImage(named: "player_unmute",               in: Bundle(for: Constants.self), compatibleWith: nil)
        static let fullScreenImage          = UIImage(named: "enterFullScreen",             in: Bundle(for: Constants.self), compatibleWith: nil)
        static let dismissImage             = UIImage(named: "xmark",                       in: Bundle(for: Constants.self), compatibleWith: nil)
        static let notAvailablePlayingImage = UIImage(named: "play.slash",                  in: Bundle(for: Constants.self), compatibleWith: nil)
        static let overlayForwardImage      = UIImage(named: "forward.fill",                in: Bundle(for: Constants.self), compatibleWith: nil)
        static let overlayRewindImage       = UIImage(named: "backward.fill",               in: Bundle(for: Constants.self), compatibleWith: nil)
    }
}
