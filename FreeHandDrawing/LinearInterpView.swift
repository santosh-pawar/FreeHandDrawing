//
//  LinearInterpView.swift
//  FreeHandDrawing
//
//  Created by Pawar, Santosh-CW on 4/22/15.
//  Copyright (c) 2015 Pawar, Santosh. All rights reserved.
//

import UIKit

class LinearInterpView: UIView {

    var path:UIBezierPath?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.multipleTouchEnabled = true
        self.backgroundColor = UIColor.whiteColor()
        path = UIBezierPath()
        path?.lineWidth = 2.0
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.blackColor().setStroke()
        path?.stroke()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject()! as UITouch
        let location = touch.locationInView(self)

        path?.moveToPoint(location)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject()! as UITouch
        let location = touch.locationInView(self)
        
        path?.addLineToPoint(location)
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        self.touchesEnded(touches, withEvent: event)
    }
}
