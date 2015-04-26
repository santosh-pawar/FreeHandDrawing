//
//  BezierInterpView.swift
//  FreeHandDrawing
//
//  Created by Pawar, Santosh-CW on 4/24/15.
//  Copyright (c) 2015 Pawar, Santosh. All rights reserved.
//

import UIKit

class BezierInterpView: UIView {

    var path:UIBezierPath?
    var incrementalImage:UIImage?
    
    var points = [CGPoint?](count: 4, repeatedValue: nil)
    var counter:Int?
    
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
        counter = 0
        let touch = touches.anyObject()!as UITouch
        points[0] = touch.locationInView(self)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject()!as UITouch
        var point = touch.locationInView(self)
        counter = counter! + 1
        points[counter!] = point
        if counter == 3{
            path?.moveToPoint(points[0]!)
            path?.addCurveToPoint(points[3]!, controlPoint1: points[1]!, controlPoint2: points[2]!)
            self.setNeedsDisplay()
            points[0] = path!.currentPoint
            counter = 0
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.drawBitmap()
        self.setNeedsDisplay()
        points[0] = path!.currentPoint
        path?.removeAllPoints()
        counter = 0
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
