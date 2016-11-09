//
//  ViewController.swift
//  watchTune
//
//  Created by Vitor Muniz on 07/11/16.
//  Copyright © 2016 Vitor Muniz. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblNote: UILabel!
    
    var mic: AKMicrophone!
    var oscillator = AKOscillator()
    var tracker: AKFrequencyTracker!
    var silence: AKBooster!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AKSettings.audioInputEnabled = true
        mic = AKMicrophone()
        tracker = AKFrequencyTracker.init(mic)
        silence = AKBooster(tracker, gain: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioKit.output = silence
        AudioKit.start()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateUI), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(){
        
        if tracker.amplitude > 0.1 {
           let note = MusicUtilities.detectPitch(frequencyValue: tracker.frequency)
           lblNote.text = "\(note.noteName)\(note.octave) frequency:\(note.noteFrequency)"
           
           //print(MusicUtilities.noteDiference(firstFrequency: MusicUtilities.frequencyFor(noteSymbol:"C", octave:"2"), secondFrequency: Float(tracker.frequency)))
           let direction =  MusicUtilities.directionToTune(desireNote:"A", currentFrequency: tracker.frequency)
           print(direction)
        }
    }
}
