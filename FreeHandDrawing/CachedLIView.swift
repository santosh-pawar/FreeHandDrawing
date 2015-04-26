//
//  CachedLIView.swift
//  FreeHandDrawing
//
//  Created by Pawar, Santosh-CW on 4/24/15.
//  Copyright (c) 2015 Pawar, Santosh. All rights reserved.
//

import UIKit

class CachedLIView: UIView {
    
    var path:UIBezierPath?
    var incrementalImage:UIImage?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.multipleTouchEnabled = true
        self.backgroundColor = UIColor.whiteColor()
        path = UIBezierPath()
        path?.lineWidth = 10.0
    }
    
    override func drawRect(rect: CGRect) {
        incrementalImage?.drawInRect(rect)
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
        let touch = touches.anyObject()!as UITouch
        let location = touch.locationInView(self)
        
        path?.addLineToPoint(location)
        self.drawBitmap()
        self.setNeedsDisplay()
        path?.removeAllPoints()
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        self.touchesEnded(touches, withEvent: event)
    }
    
    
    func drawBitmap(){
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0.0)
        UIColor.blackColor().setStroke()
        if((incrementalImage) == nil){
            var rectPath:UIBezierPath = UIBezierPath(rect: self.bounds)
            UIColor.whiteColor().setFill()
            rectPath.fill()
        }
        
        incrementalImage?.drawAtPoint(CGPointZero)
        path?.stroke()
        incrementalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

}
