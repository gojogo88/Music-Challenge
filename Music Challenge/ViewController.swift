//
//  ViewController.swift
//  Music Challenge
//
//  Created by Jonathan Go on 2017/01/22.
//  Copyright © 2017 Appdelight. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    
    let audioPath = Bundle.main.path(forResource: "bitch", ofType: "mp3")
    
    var timer = Timer()
    
    @objc func updateScrubber() {
        
        
        scrubSlider.value = Float(player.currentTime)
        
    }
    
    
    @IBAction func playButton(_ sender: Any) {
        
        player.play()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func pauseButton(_ sender: Any) {
        
        player.pause()
        
        timer.invalidate()
        
    }
    
    
    @IBAction func stopButton(_ sender: Any) {
        
        scrubSlider.value = 0
        
        timer.invalidate()
        
        player.pause()

        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
        } catch {
            
            // process errors here
            
        }
        
    }

    @IBAction func audioSliderMoved(_ sender: Any) {
        
        player.volume = audioSlider.value
    }
    
    @IBAction func scrubSliderMoved(_ sender: Any) {
        
        player.currentTime = TimeInterval(scrubSlider.value)
        
    }
    
    
    @IBOutlet weak var scrubSlider: UISlider!
    
    @IBOutlet weak var audioSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
            scrubSlider.maximumValue = Float(player.duration)
            
        } catch {
            
            // process errors here
            
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

