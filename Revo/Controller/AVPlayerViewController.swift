import UIKit

class AVPlayerViewController: UIViewController  {
    let musicPlayerView: MusicPlayerView = {
        let musicPlayerView = MusicPlayerView()
        musicPlayerView.translatesAutoresizingMaskIntoConstraints = false
        return musicPlayerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Part 2"
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(musicPlayerView)
        setupMusicPlayerLauncher()
    }
    
    deinit {
        musicPlayerView.stop()
        
    }
    
    private func setupMusicPlayerLauncher() {
        let offset = self.topbarHeight * -1
        musicPlayerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        musicPlayerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset).isActive = true
        musicPlayerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        musicPlayerView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}


