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
        
    private let pauseImage = UIImage(named: "pause")?.withRenderingMode(.alwaysOriginal)
    private let playImage = UIImage(named: "play")?.withRenderingMode(.alwaysOriginal)

    lazy private var playButton: UIButton = {
        var playButton = UIButton(type: .system)
        playButton.setImage(playImage, for: .normal)
        playButton.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    lazy private var replayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "rewind")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = UIColor(r: 43, g: 142, b: 240)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(restartPlayer(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        self.layer.addSublayer(playerLayer)
        self.addSubview(playButton)
        self.addSubview(albumImage)
        self.addSubview(replayButton)
        self.addSubview(readyLabel)
        self.setupPlayButton()
        self.setupReplayButton()
        self.setupAlbumImage()
        self.setupReadyLabel()
    }
}

// Button actions
extension MusicPlayerView {
    @objc func playButtonTapped(_ sender:UIButton) {
        if player.rate == 0 {
            self.player.play()
            self.playButton.setImage(pauseImage, for: .normal)
        } else {
            self.player.pause()
            self.playButton.setImage(playImage, for: .normal)
        }
    }
    
    @objc func playerDidFinishPlaying(sender: Notification) {
        self.player.seek(to: .zero)
        self.playButton.setImage(playImage, for: .normal)
    }
    
    @objc func restartPlayer(_ sender: UIButton) {
        self.player.seek(to: .zero)
    }
}

// Setup Views
extension MusicPlayerView {
    private func setupPlayer() {
        NetworkOperations().download(songLink: "https://audio-ssl.itunes.apple.com/itunes-assets/Music1/v4/76/dc/97/76dc9799-5357-99a5-07c6-b73e86c03e60/mzaf_6420206879621100054.plus.aac.p.m4a") { (url) in
            print("done")
            let url = URL(string: url)
            let playerItem: AVPlayerItem = AVPlayerItem(url: url!)
            NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
            self.player = AVPlayer(playerItem: playerItem)
            DispatchQueue.main.async {
                self.readyLabel.text = "Ready to play!"
            }
        }
    }
    
    private func setupAlbumImage() {
//        let offset = -1 * topBarHeight
        self.albumImage.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.albumImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        self.albumImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.albumImage.centerYAnchor.constraint(equalTo: self.centerYAnchor/*, constant: offset*/).isActive = true
    }
    
    private func setupPlayButton() {
        self.playButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.playButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.playButton.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 50).isActive = true
    }
    
    private func setupReplayButton() {
        self.replayButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        self.replayButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        self.replayButton.centerYAnchor.constraint(equalTo: self.playButton.centerYAnchor).isActive = true
        self.replayButton.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -15).isActive = true
    }
    
    private func setupReadyLabel() {
        self.readyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.readyLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 30).isActive = true
    }
}
