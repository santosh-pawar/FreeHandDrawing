//
//  ViewController.swift
//  FreeHandDrawing
//
//  Created by Pawar, Santosh-CW on 4/22/15.
//  Copyright (c) 2015 Pawar, Santosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        switch(segue.identifier!){
        case "chooseColor":
            var schoolListTC = (segue.destinationViewController as? PopOverTableVC)!
            break
        default:
            break
        }
    }
}

