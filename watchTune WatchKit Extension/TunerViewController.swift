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
