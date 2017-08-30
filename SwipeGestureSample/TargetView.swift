//
//  TargetView.swift
//  SwipeGestureSample
//
//  Created by Lee Myung seok on 2017. 8. 26..
//  Copyright © 2017년 Lee Myung seok. All rights reserved.
//

import UIKit
import SnapKit

class TargetView: UIView {
    
    enum Status {
        case min, max
    }
    
    var topConstraint: Constraint!
    
    var currentStatus: Status = .min
    
    let maxYPosition: CGFloat = -400
    let minYPosition : CGFloat = -200
    
    func initialize(topConstraint: Constraint) {
        self.topConstraint = topConstraint
        self.topConstraint.update(offset: -200)
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGestureAction(recognizer:))))
    }
    
    @IBAction func dfsdfsd(_ sender: Any) {
        
        if let parentView = topConstraint.layoutConstraints[0].secondItem as? UIView {
            parentView.needsUpdateConstraints()
            self.topConstraint.update(offset: self.currentStatus == .max ? self.minYPosition : self.maxYPosition)
            UIView.animate(withDuration: 0.3) {
                parentView.layoutIfNeeded()
            }
            
            currentStatus = currentStatus == .min ? .max : .min
        }

    }
    
    func panGestureAction(recognizer: UIPanGestureRecognizer) {
        
        let currentOffset = topConstraint.layoutConstraints[0].constant
        
        switch recognizer.state {
        case .began:
            break
        case .changed where currentOffset >= maxYPosition && currentOffset <= minYPosition:
            let startPosition = self.currentStatus == .min ? minYPosition : maxYPosition
            
            var val: CGFloat = startPosition + recognizer.translation(in: self).y
            
            if val < maxYPosition {
                val = maxYPosition
            }
            else if val > minYPosition {
                val = minYPosition
            }
            
            self.topConstraint.update(offset: val)
        case .ended:
            let isUp = recognizer.velocity(in: self).y < 0
            if let parentView = topConstraint.layoutConstraints[0].secondItem as? UIView {
                parentView.needsUpdateConstraints()
                self.topConstraint.update(offset: isUp ? maxYPosition : minYPosition)

                UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: { () -> Void in
                    parentView.layoutIfNeeded()
                })
            }
            
            currentStatus = isUp ? .max : .min
            
        default:
            break
        }
            }
}
