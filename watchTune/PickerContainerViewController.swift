//
//  PickerContainerViewController.swift
//  watchTune
//
//  Created by Yuri Saboia Felix Frota on 08/11/16.
//  Copyright © 2016 Vitor Muniz. All rights reserved.
//

import UIKit
import AKPickerView

class PickerContainerViewController: UIViewController, AKPickerViewDelegate, AKPickerViewDataSource {

    let noteNames = ["C", "C♯","D","D♯","E","F","F♯","G","G♯","A","A♯","B"]
    
    var pickerView : AKPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView = AKPickerView.init(frame: self.view.frame)
        self.pickerView.delegate  = self
        self.pickerView.dataSource = self
        
        
        
        let dragGestureRight = UISwipeGestureRecognizer(target: self, action: Selector(("respondToSwipe:")))
        let dragGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        dragGestureLeft.direction = .left
        dragGestureRight.direction = .right
        
        self.pickerView.addGestureRecognizer(dragGestureRight)
        self.pickerView.addGestureRecognizer(dragGestureLeft)
        
        self.view.addSubview(self.pickerView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidLayoutSubviews() {
        configurePicker()
    }
    
    
    func configurePicker(){
        self.pickerView.frame = self.view.frame
        self.pickerView.textColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
        self.pickerView.interitemSpacing = 20.0
        self.pickerView.font = UIFont(name: "Avenir Next", size: 40)
        self.pickerView.highlightedFont = UIFont(name: "Avenir Next", size: 40)
        self.pickerView.highlightedTextColor = UIColor.red
        self.pickerView.fisheyeFactor = 0.001
        
        self.pickerView.reloadData()
    }
    
    func respondToSwipe(gesture : UISwipeGestureRecognizer){
        if gesture.state == .began{
            self.pickerView.textColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.02)
            self.pickerView.reloadData()
        }
        if gesture.state == .ended{
            self.pickerView.textColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
            self.pickerView.reloadData()
        }
    }
    
    func numberOfItems(in pickerView: AKPickerView!) -> UInt {
        return UInt(self.noteNames.count)
    }
    
    func pickerView(_ pickerView: AKPickerView!, titleForItem item: Int) -> String! {
        return noteNames[item]
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
