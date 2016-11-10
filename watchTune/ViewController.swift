//
//  ViewController.swift
//  watchTune
//
//  Created by Vitor Muniz on 07/11/16.
//  Copyright © 2016 Vitor Muniz. All rights reserved.
//

import UIKit
import AudioKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
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
    
    var session : WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activate()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.session = WCSession.default()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.picker = self.childViewControllers.last as! PickerContainerViewController!
        self.circles = self.childViewControllers.first as! CircleContainerViewController!
        AKSettings.audioInputEnabled = true
        mic = AKMicrophone()
        tracker = AKFrequencyTracker.init(mic)
        silence = AKBooster(tracker, gain: 0)
        self.paintBackground(number: 4)
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
            case _ where number <= -0.75:
                paintBackground(number: 8)
            case _ where number <= -0.50 && number >= -0.75:
                paintBackground(number: 7)
            case _ where number <= -0.25 && number >= -0.50:
                paintBackground(number: 6)
            case _ where number <= 0.0 && number >= -0.25:
                paintBackground(number: 5)
            case _ where number == 0:
                paintBackground(number: 4)
            case _ where number > 0 && number < 0.25:
                paintBackground(number: 3)
            case _ where number > 0.25 && number < 0.5:
                paintBackground(number: 2)
            case _ where number > 0.5 && number < 0.75:
                paintBackground(number: 2)
            case _ where number > 0.75 && number <= 1.0:
                paintBackground(number: 1)
            default:
                paintBackground(number: 4)
            }
        }
    }
    
    
    func paintBackground(number : Int) {
        self.circles.printCircles(filledCircle: CGFloat(number))
        self.view.backgroundColor = (colors[number])
        self.circles.view.backgroundColor = (colors[number])
        self.picker.view.backgroundColor = (colors[number])
        
        if session!.isReachable{
            self.session!.sendMessage(["value" : number], replyHandler: nil, errorHandler: nil)
        }else{
            print("App not reachable")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //TODO
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //TODO
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let erro = error{
            print(erro.localizedDescription)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let note = message["index"] {
            self.picker.lastSelectedItem = UInt(note as! Int)
            self.picker.pickerView.selectItem(UInt(note as! Int), animated: false)
            print(self.picker.lastSelectedItem)
        }
    }
    
}
