//
//  TunerViewController.swift
//  watchTune
//
//  Created by Yuri Saboia Felix Frota on 09/11/16.
//  Copyright © 2016 Vitor Muniz. All rights reserved.
//

import UIKit
import WatchKit

class TunerViewController: WKInterfaceController {
    
    @IBOutlet var note: WKInterfaceLabel!
    
    var colors = [UIColor(red: 63.0/255.0, green: 225.0/255.0, blue: 232.0/255.0, alpha: 1.0),                                                 // Blues
        UIColor(red: 67.0/255.0, green: 158.0/255.0, blue: 224.0/255.0, alpha: 1.0),
        UIColor(red: 53.0/255.0, green: 102.0/255.0, blue: 181.0/255.0, alpha: 1.0),
        UIColor(red: 52.0/255.0, green: 76.0/255.0, blue: 209.0/255.0, alpha: 1.0),
        UIColor(red: 96.0/255.0, green: 170.0/255.0, blue: 82.0/255.0, alpha: 1.0),                                                //Green
        UIColor(red: 235.0/255.0, green: 233.0/255.0, blue: 47.0/255.0, alpha: 1.0),                                              //Reds
        UIColor(red: 247.0/255.0, green: 204.0/255.0, blue: 46.0/255.0, alpha: 1.0),
        UIColor(red: 227.0/255.0, green: 147.0/255.0, blue: 36.0/255.0, alpha: 1.0),
        UIColor(red: 227.0/255.0, green: 103.0/255.0, blue: 26.0/255.0, alpha: 1.0)]
    
    var choosenNote: String = ""
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        choosenNote = context as! String
        note.setText(choosenNote)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func stopBtn() {
        //Close connectivity
    }
}
