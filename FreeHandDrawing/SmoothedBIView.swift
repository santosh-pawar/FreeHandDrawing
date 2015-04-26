//
//  SmoothedBIView.swift
//  FreeHandDrawing
//
//  Created by Pawar, Santosh-CW on 4/24/15.
//  Copyright (c) 2015 Pawar, Santosh. All rights reserved.
//

import UIKit

class SmoothedBIView: UIView {
    
    var path:UIBezierPath?
    var incrementalImage:UIImage?
    
    var points = [CGPoint?](count: 5, repeatedValue: nil)
    var counter:Int?
    
    var infoView:UIView = UIView()
    var strokeColor:UIColor?
    
    
    //MARK: Lifecycle methods
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.multipleTouchEnabled = false
        self.backgroundColor = UIColor.whiteColor()
        path = UIBezierPath()
        path?.lineWidth = 10.0
        strokeColor = UIColor.blackColor()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.multipleTouchEnabled = false
        path = UIBezierPath()
        path?.lineWidth = 10.0
    }
    
    
    override func drawRect(rect: CGRect) {
        incrementalImage?.drawInRect(rect)
        strokeColor?.setStroke()
        path?.stroke()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        counter = 0
        let touch = touches.anyObject()!as UITouch
        points[0] = touch.locationInView(self)
        infoView.removeFromSuperview()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject()!as UITouch
        var point = touch.locationInView(self)
        counter = counter! + 1
        points[counter!] = point
        if counter == 4{
            
            points[3]! = CGPointMake((points[2]!.x + points[4]!.x)/2.0, (points[2]!.y + points[4]!.y)/2.0)
            path?.moveToPoint(points[0]!)
            path?.addCurveToPoint(points[3]!, controlPoint1: points[1]!, controlPoint2: points[2]!)
            self.setNeedsDisplay()
            points[0]! = points[3]!
            points[1]! = points[4]!
            counter = 1
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.drawBitmap()
        self.setNeedsDisplay()
        path?.removeAllPoints()
        counter = 0
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        self.touchesEnded(touches, withEvent: event)
    }
    
    //MARK: Cache method
    func drawBitmap(){
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0.0)
        strokeColor?.setStroke()
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
 
    //MARK:Action methods
    func erase(){
        path = nil
        incrementalImage = nil
        path = UIBezierPath()
        path?.lineWidth = 10.0
        strokeColor = UIColor.blackColor()
        self.setNeedsDisplay()
    }
    
    @IBAction func clearScreen(sender: AnyObject) {
        self.erase()
    }
}
