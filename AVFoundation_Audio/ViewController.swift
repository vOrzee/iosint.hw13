//
//  ViewController.swift
//  AVFoundation_Audio
//
//  Created by Niki Pavlove on 18.02.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var songName: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    var Player = AVAudioPlayer()
    let tracksName: [String] = [
        "Queen.mp3",
        "AMALGAM.mp3",
        "Creative Technology Showreel.mp3",
        "Drive Breakbeat.mp3",
        "Flow.mp3",
        "Midnight Forest.mp3",
    ]
    var currentTrack: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareToPlay()
    }

    @IBAction func PlayButton(_ sender: Any) {
        if Player.isPlaying {
            Player.stop()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            Player.play()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    @IBAction func StopButton(_ sender: Any) {
        Player.stop()
        Player.currentTime = 0
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    @IBAction func forwardSong(_ sender: Any) {
        if currentTrack == tracksName.count - 1 { currentTrack = 0 }
        else { currentTrack += 1 }
        prepareToPlay()
        Player.play()
        playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    @IBAction func backwardSong(_ sender: Any) {
        if currentTrack == 0 { currentTrack = tracksName.count - 1 }
        else { currentTrack -= 1 }
        prepareToPlay()
        Player.play()
        playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    func prepareToPlay() {
        do {
            let splitFileName: [String] = tracksName[currentTrack].split(separator: ".").map { String($0) }
            guard let nameSong = splitFileName.first, let typeSongFile = splitFileName.last else {return}
            songName.text = nameSong
            Player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: nameSong, ofType: typeSongFile)!))
            Player.prepareToPlay()
            songName.sizeToFit()
        }
        catch {
            print(error)
        }
    }
}
