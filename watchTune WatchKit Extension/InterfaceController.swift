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
    
    
    @IBOutlet var lblNote: WKInterfaceLabel!
   
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
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

    
    
}
