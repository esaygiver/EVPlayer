//
//  MockEVMedia.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 26.03.2023.
//

import EVPlayer

let mockMedia = EVMedia(videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")!,
                        thumbnailURL: URL(fileURLWithPath: Bundle.main.path(forResource: "defaultThumbnail2", ofType: "png") ?? ""))
