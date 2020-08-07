//
//  MusicPlayer.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/5/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerView: UIView {
    private var player: AVPlayer!
    private var shouldChangeSlider: Bool = true
    
    private let albumImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "elvis")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let readyLabel: UILabel = {
        let label = UILabel()
        label.text = "Downloading..."
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let pauseImage = UIImage(named: "pause")?.withRenderingMode(.alwaysOriginal)
    private let playImage = UIImage(named: "play")?.withRenderingMode(.alwaysOriginal)

    lazy private var playButton: UIButton = {
        var playButton = UIButton(type: .system)
        playButton.setImage(playImage, for: .normal)
        playButton.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.isEnabled = false
        return playButton
    }()
    
    lazy private var replayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "rewind")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = UIColor(r: 43, g: 142, b: 240)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(restartPlayer(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    lazy var musicSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .systemBlue
        slider.maximumTrackTintColor = .lightGray
        slider.addTarget(self, action: #selector(handleSliderChange(sender:event:)), for: .valueChanged)
        return slider
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.setupPlayer()
        let playerLayer = AVPlayerLayer(player: player)
        layer.addSublayer(playerLayer)
        addSubview(playButton)
        addSubview(albumImage)
        addSubview(replayButton)
        addSubview(readyLabel)
        addSubview(musicSlider)
        addSubview(currentTimeLabel)
        addSubview(videoLengthLabel)
        setupPlayButton()
        setupReplayButton()
        setupAlbumImage()
        setupReadyLabel()
        setupMusicSlider()
        setupCurrentTimeLabel()
        setupVideoLengthLabel()
    }
}

// Actions
extension MusicPlayerView {
    func stop() {
        player.pause()
        player.replaceCurrentItem(with: nil)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        if player.rate == 0 {
            player.play()
            playButton.setImage(pauseImage, for: .normal)
        } else {
            player.pause()
            playButton.setImage(playImage, for: .normal)
        }
    }
    
    @objc func playerDidFinishPlaying(sender: Notification) {
        restart()
        playButton.setImage(playImage, for: .normal)
    }
    
    @objc func restartPlayer(_ sender: UIButton) {
        restart()
    }
    
    private func restart() {
        shouldChangeSlider = false
        player.seek(to: .zero)
        musicSlider.value = 0
        shouldChangeSlider = true
    }
    
    @objc func handleSliderChange(sender: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                shouldChangeSlider = false
            case .ended:
                if let duration = player?.currentItem?.duration {
                    let totalSeconds = CMTimeGetSeconds(duration)
                    let value = Float64(musicSlider.value) * totalSeconds
                    let seekTime = CMTime(value: Int64(value), timescale: 1)
                    player?.seek(to: seekTime, completionHandler: { _ in })
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.shouldChangeSlider = true
                }
            default: break
            }
        }
    }
}

// Setup subviews
extension MusicPlayerView {
    private func setupPlayer() {
        NetworkOperations().download(songLink: "https://audio-ssl.itunes.apple.com/itunes-assets/Music1/v4/76/dc/97/76dc9799-5357-99a5-07c6-b73e86c03e60/mzaf_6420206879621100054.plus.aac.p.m4a") { (url) in
            let url = URL(string: url)
            let playerItem: AVPlayerItem = AVPlayerItem(url: url!)
            NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
            self.player = AVPlayer(playerItem: playerItem)
            
            self.player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 1)
            self.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { (progressTime) in
                if let currentTime = self.player.currentItem?.currentTime() {
                    let seconds = CMTimeGetSeconds(currentTime)
                                        
                    let secondsText = String(format: "%02d", Int(seconds))
                    let minutesText = String(format: "%02d", Int(seconds) / 60)
                                        
                    self.currentTimeLabel.text = "\(minutesText):\(secondsText)"
                }
                
                let seconds = CMTimeGetSeconds(progressTime)
                DispatchQueue.main.async {
                    if let duration = self.player?.currentItem?.duration {
                        let durationSeconds = CMTimeGetSeconds(duration)
                        
                        // check for cases where user is pressing on slider
                        // and prevents from bouncing backwards
                        if self.shouldChangeSlider {
                            self.musicSlider.value = Float(seconds / durationSeconds)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.readyLabel.text = "Ready to play!"
                self.playButton.isEnabled = true
                self.replayButton.isEnabled = true
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                guard !(seconds.isNaN || seconds.isInfinite) else {              
                    return
                }
                
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    private func setupMusicSlider() {
        musicSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        musicSlider.heightAnchor.constraint(equalToConstant: 15).isActive = true
        musicSlider.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 20).isActive = true
        musicSlider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupCurrentTimeLabel() {
        currentTimeLabel.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: 15).isActive = true
        currentTimeLabel.leftAnchor.constraint(equalTo: musicSlider.leftAnchor).isActive = true
    }
    
    private func setupVideoLengthLabel() {
        videoLengthLabel.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: 15).isActive = true
        videoLengthLabel.rightAnchor.constraint(equalTo: musicSlider.rightAnchor).isActive = true
    }
    
    private func setupAlbumImage() {
        albumImage.widthAnchor.constraint(equalToConstant: 300).isActive = true
        albumImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        albumImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        albumImage.centerYAnchor.constraint(equalTo: self.centerYAnchor/*, constant: offset*/).isActive = true
    }
    
    private func setupPlayButton() {
        playButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        playButton.topAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    private func setupReplayButton() {
        replayButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        replayButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        replayButton.centerYAnchor.constraint(equalTo: self.playButton.centerYAnchor).isActive = true
        replayButton.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -15).isActive = true
    }
    
    private func setupReadyLabel() {
        readyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        readyLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 30).isActive = true
    }
}
