//
//  CircleContainerViewController.swift
//  watchTune
//
//  Created by Yuri Saboia Felix Frota on 08/11/16.
//  Copyright © 2016 Vitor Muniz. All rights reserved.
//

import UIKit

class CircleContainerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        for x in 0...8{
            drawCircle(position: CGFloat(x), filled: false)
        }
        drawCircle(position: 5, filled: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    public func drawCircle(position: CGFloat, filled : Bool){
        let halfSize:CGFloat = 7
        let desiredLineWidth:CGFloat = 1    // your desired value
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: (position * self.view.bounds.width/8),y: self.view.bounds.height/2),
            radius: CGFloat( halfSize - (desiredLineWidth/2) ),
            startAngle: CGFloat(0),
            endAngle:CGFloat(M_PI * 2),
            clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        if(filled){
            shapeLayer.fillColor = UIColor.red.cgColor
        }else{
            shapeLayer.fillColor = UIColor.clear.cgColor
        }
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = desiredLineWidth
        
        self.view.layer.addSublayer(shapeLayer)
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
