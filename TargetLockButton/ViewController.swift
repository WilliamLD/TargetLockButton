//
//  ViewController.swift
//  TargetLockButton
//
//  Created by Ding on 3/15/16.
//  Copyright © 2016 Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetLockButton: TargetLockButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        targetLockButton.allowsTouchTracking = true
        
//        targetLockButton.layer.cornerRadius = 90
//        targetLockButton.layer.backgroundColor = targetLockButton.backgroundColor?.CGColor
//        targetLockButton.layer.borderColor = UIColor.redColor().CGColor
//        targetLockButton.layer.borderWidth = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

