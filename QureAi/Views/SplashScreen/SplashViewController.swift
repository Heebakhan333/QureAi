//
//  SplashViewController.swift
//  QureAi
//
//  Created by Heeba Khan on 16/05/24.
//

import UIKit
import AVKit


//For animation in the Splash Screen
class SplashViewController: UIViewController {
    
    
    //MARK: Variables
    var navigator: Navigator?
    var player: AVPlayer?
    // var playerView: VideoPlayerView!
    
    //MARK: Outlets
    @IBOutlet var videoView: VideoPlayerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playVideo()
        navigator = Navigator(vc: self)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Ensure player starts playing when view appears
        player?.play()
    }
    
    // Optional: You can add functions to control playback
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: .zero)
    }
    
    //MARK: Private functions
    
    private func configure(){
        navigator = Navigator(vc: self)
        playVideo()
    }
    
    private func playVideo() {
        guard let url = Bundle.main.url(forResource: "splash_video", withExtension: "mp4") else {
            fatalError("video url can't be played")
        }
        player = AVPlayer(url: url)
        
        // Initialize PlayerView
        videoView = VideoPlayerView(frame: view.bounds)
        videoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        videoView.contentMode = .scaleAspectFill
        videoView.player = player
        
        // Add PlayerView to the ViewController's view
        view.addSubview(videoView)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Update playerView frame to match new size after rotation
        guard let playerView = videoView else {
            return
        }
        
        let safeAreaFrame = view.bounds
        if #available(iOS 11.0, *) {
            let safeAreaInsets = view.safeAreaInsets
            playerView.frame = CGRect(x: safeAreaFrame.origin.x + safeAreaInsets.left,
                                      y: safeAreaFrame.origin.y + safeAreaInsets.top,
                                      width: safeAreaFrame.width ,
                                      //- safeAreaInsets.left - safeAreaInsets.right,
                                      height: safeAreaFrame.height)
            //- safeAreaInsets.top - safeAreaInsets.bottom)
        } else {
            playerView.frame = safeAreaFrame
        }
    }
    
    @objc func playerDidFinishPlaying(_ notification: Notification) {
        self.pushVC()
//        if (self.navigationController?.visibleViewController == self) {
//            performSegue(withIdentifier: "goToOnboardingPage", sender: self)
//        }
     //   performSegue(withIdentifier: "goToOnboardingPage", sender: self)
    }
    
    func pushVC() {
        guard let vc = navigator?.instantiateVC(withDestinationViewControllerType: LandingPageViewController.self) else { return }
        // vc.someString = "SOME STRING TO BE PASSED"
        navigator?.goTo(viewController: vc, withDisplayVCType: .push)
    }
    
    deinit {
        // Remove observer
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
}
