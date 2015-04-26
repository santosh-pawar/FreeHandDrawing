//
//  PopOverTableVC.swift
//  FreeHandDrawing
//
//  Created by Pawar, Santosh-CW on 4/25/15.
//  Copyright (c) 2015 Pawar, Santosh. All rights reserved.
//

import UIKit

class PopOverTableVC: UITableViewController,UIPopoverPresentationControllerDelegate {

//    var smoothView:SmoothedBIView?
    var selectedColor:UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        smoothView = SmoothedBIView(coder: aDecoder)

        // popover settings
        modalPresentationStyle = .Popover
        popoverPresentationController!.delegate = self
        
        self.preferredContentSize = CGSize(width:100,height:130)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //selected a color
//        let colorChosen = tableView.cellForRowAtIndexPath(indexPath)!.textLabel!.text
//        println("Selected Color: \(colorChosen)")
//        smoothView!.strokeColor = UIColor.greenColor()
        selectedColor = UIColor.greenColor()
        dismissViewControllerAnimated(true, completion:nil)
    }
    
    func adaptivePresentationStyleForPresentationController(PC: UIPresentationController) -> UIModalPresentationStyle{
        
        return .None
    }
    
    func presentationController(_: UIPresentationController, viewControllerForAdaptivePresentationStyle _: UIModalPresentationStyle)
        -> UIViewController?{
            return UINavigationController(rootViewController: self)
    }
}
