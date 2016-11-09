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
    let noteNames = ["C", "C♯","D","D♯","E","F","F♯","G","G♯","A","A♯","B"]
    
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
    var oscillator = AKOscillator()
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
            
            let number = MusicUtilities.directionToTune(desireNote: noteNames[Int(picker.lastSelectedItem)], currentFrequency: self.tracker.frequency)
            switch number {
            case _ where number <= -0.80:
                self.circles.printCircles(filledCircle: CGFloat(0))
                self.view.backgroundColor = (colors[0])
                self.circles.view.backgroundColor = (colors[0])
                self.picker.view.backgroundColor = (colors[0])
            case _ where number <= -0.60 && number >= -0.80:
                self.circles.printCircles(filledCircle: CGFloat(1))
                self.view.backgroundColor = (colors[1])
                self.circles.view.backgroundColor = (colors[1])
                self.picker.view.backgroundColor = (colors[1])
            case _ where number <= -0.40 && number >= -0.60:
                self.circles.printCircles(filledCircle: CGFloat(2))
                self.view.backgroundColor = (colors[2])
                self.circles.view.backgroundColor = (colors[2])
                self.picker.view.backgroundColor = (colors[2])
            case _ where number <= -0.20 && number >= -0.40:
                self.circles.printCircles(filledCircle: CGFloat(3))
                self.view.backgroundColor = (colors[3])
                self.circles.view.backgroundColor = (colors[3])
                self.picker.view.backgroundColor = (colors[3])
            case _ where number < 0 && number >= -0.20:
                self.circles.printCircles(filledCircle: CGFloat(3))
                self.view.backgroundColor = (colors[3])
                self.circles.view.backgroundColor = (colors[3])
                self.picker.view.backgroundColor = (colors[3])
            case _ where number == 0:
                self.circles.printCircles(filledCircle: CGFloat(4))
                self.view.backgroundColor = (colors[4])
                self.circles.view.backgroundColor = (colors[4])
                self.picker.view.backgroundColor = (colors[4])
            case _ where number > 0 && number < 0.2:
                self.circles.printCircles(filledCircle: CGFloat(5))
                self.view.backgroundColor = (colors[5])
                self.circles.view.backgroundColor = (colors[5])
                self.picker.view.backgroundColor = (colors[5])
            case _ where number > 0.2 && number < 0.4:
                self.circles.printCircles(filledCircle: CGFloat(6))
                self.view.backgroundColor = (colors[6])
                self.circles.view.backgroundColor = (colors[6])
                self.picker.view.backgroundColor = (colors[6])
            case _ where number > 0.4 && number < 0.6:
                self.circles.printCircles(filledCircle: CGFloat(7))
                self.view.backgroundColor = (colors[7])
                self.circles.view.backgroundColor = (colors[7])
                self.picker.view.backgroundColor = (colors[7])
            case _ where number > 0.6 && number < 0.8:
                self.circles.printCircles(filledCircle: CGFloat(7))
                self.view.backgroundColor = (colors[7])
                self.circles.view.backgroundColor = (colors[7])
                self.picker.view.backgroundColor = (colors[7])
            case _ where number > 0.8:
                self.circles.printCircles(filledCircle: CGFloat(8))
                self.view.backgroundColor = (colors[8])
                self.circles.view.backgroundColor = (colors[8])
                self.picker.view.backgroundColor = (colors[8])
            default:
                self.circles.printCircles(filledCircle: CGFloat(4))
                self.view.backgroundColor = (colors[4])
                self.circles.view.backgroundColor = (colors[4])
                self.picker.view.backgroundColor = (colors[4])
            }
        }
    }
}
