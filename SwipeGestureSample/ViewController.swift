//
//  ViewController.swift
//  SwipeGestureSample
//
//  Created by Lee Myung seok on 2017. 8. 26..
//  Copyright © 2017년 Lee Myung seok. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet var targetView: TargetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(self.targetView)
        
        var topConstraint: Constraint?
        
        self.targetView.snp.makeConstraints { (make) in
            topConstraint = make.top.equalTo(self.view.snp.bottom).constraint
            make.leading.trailing.equalTo(self.view)
            make.height.equalTo(400)
            
        }
        
        targetView.initialize(topConstraint: topConstraint!)
        
    }
}



