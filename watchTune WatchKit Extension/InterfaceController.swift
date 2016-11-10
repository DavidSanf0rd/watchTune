//
//  InterfaceController.swift
//  watchTune WatchKit Extension
//
//  Created by Vitor Muniz on 07/11/16.
//  Copyright © 2016 Vitor Muniz. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var picker: WKInterfacePicker!
    let noteNames = ["C", "C♯","D","D♯","E","F","F♯","G","G♯","A","A♯","B"]
    var currentItem = "C"
    var currentNumber = 0;
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let pickerItems : [WKPickerItem] = noteNames.map{
            let pickerItem = WKPickerItem()
            pickerItem.title = $0
            return pickerItem
        }
        
        picker.setItems(pickerItems)
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
    
    
    
    @IBAction func changedItem(_ value: Int) {
        currentItem = noteNames[value]
        currentNumber = value
    }
    
    @IBAction func beginBtn() {
        let info = ["note" : currentItem, "index" : currentNumber] as [String : Any]
        self.presentController(withName: "TuneView", context: info)
    }
    
}
