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
    
//    @IBOutlet weak var lblNote: UILabel!
    
    var colors = [UIColor(red: 63.0/255.0, green: 225.0/255.0, blue: 232.0/255.0, alpha: 1.0),                                                 // Blues
                  UIColor(red: 67.0/255.0, green: 158.0/255.0, blue: 224.0/255.0, alpha: 1.0),
                  UIColor(red: 53.0/255.0, green: 102.0/255.0, blue: 181.0/255.0, alpha: 1.0),
                  UIColor(red: 52.0/255.0, green: 76.0/255.0, blue: 209.0/255.0, alpha: 1.0),
                  UIColor(red: 96.0/255.0, green: 170.0/255.0, blue: 82.0/255.0, alpha: 1.0),                                                //Green
                  UIColor(red: 235.0/255.0, green: 233.0/255.0, blue: 47.0/255.0, alpha: 1.0),                                              //Reds
                  UIColor(red: 247.0/255.0, green: 204.0/255.0, blue: 46.0/255.0, alpha: 1.0),
                  UIColor(red: 227.0/255.0, green: 147.0/255.0, blue: 36.0/255.0, alpha: 1.0),
                  UIColor(red: 227.0/255.0, green: 103.0/255.0, blue: 26.0/255.0, alpha: 1.0)]
    
    var mic: AKMicrophone!
    var tracker: AKFrequencyTracker!
    var silence: AKBooster!
    var picker : PickerContainerViewController!
    var circles : CircleContainerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.picker = self.childViewControllers.last as! PickerContainerViewController!
        self.circles = self.childViewControllers.first as! CircleContainerViewController!
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
    
    
    
    func updateUI() {
        if tracker.amplitude > 0.1 {
           let note = MusicUtilities.detectPitch(frequencyValue: Float(tracker.frequency))
//           lblNote.text = "\(note.noteName)\(note.octave)"
           let number = Int(arc4random_uniform(8))
           self.circles.printCircles(filledCircle: CGFloat(number))
           self.view.backgroundColor = (colors[number])
           self.circles.view.backgroundColor = (colors[number])
           self.picker.view.backgroundColor = (colors[number])
        }
    }
}
