//
//  ViewController.swift
//  test
//
//  Created by Wizard Li on 1/6/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class SimpleDynamicViewController: UIViewController {

    @IBOutlet var squre: UIView!
    
    var dynamicAnimator : UIDynamicAnimator?
    var attachmentBehavior : UIAttachmentBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        let gravity = UIGravityBehavior(items: [squre])
        dynamicAnimator.addBehavior(gravity)
        
        let collisionBehavior = UICollisionBehavior(items: [squre])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
        
        let elasticityBehavior = UIDynamicItemBehavior(items: [squre])
        elasticityBehavior.elasticity = 1.0
        dynamicAnimator.addBehavior(elasticityBehavior)
        
        self.dynamicAnimator = dynamicAnimator
    }

    @IBAction func handleAttachmentGuesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
            
        case .Began:
            let squreCenterPoint = CGPointMake(squre.center.x, squre.center.y)
            let attachmentBehavior = UIAttachmentBehavior(item: squre, offsetFromCenter:UIOffset(horizontal: -25, vertical: -25), attachedToAnchor: squreCenterPoint)
            attachmentBehavior.length = 50
            attachmentBehavior.damping = 0.8
            attachmentBehavior.frequency = 1
            self.attachmentBehavior = attachmentBehavior
            dynamicAnimator?.addBehavior(attachmentBehavior)
        case .Changed:
            attachmentBehavior?.anchorPoint = gesture.locationInView(view)
            
        case .Ended:
            dynamicAnimator?.removeBehavior(attachmentBehavior!)
            
        default:
            break
        }
    }
}
