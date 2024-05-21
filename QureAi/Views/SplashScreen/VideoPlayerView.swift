//
//  VideoPlayerView.swift
//  QureAi
//
//  Created by Heeba Khan on 16/05/24.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    //MARK: Variables
    // var playerLayer: AVPlayerLayer?
    //   var playbackDidFinishCallback: (() -> Void)?
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
}
