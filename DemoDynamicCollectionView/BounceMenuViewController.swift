//
//  BounceMenuViewController.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/15/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class BounceMenuViewController : UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    var dynamicAnimator : UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.layer.shadowColor = UIColor.orangeColor().CGColor
        contentView.layer.shadowOpacity = 1.0
        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).CGPath
        contentView.layer.shadowOffset = CGSizeZero
        contentView.layer.shadowRadius = 5.0
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        let collision = UICollisionBehavior(items: [contentView])
        collision.setTranslatesReferenceBoundsIntoBoundaryWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -280))
        dynamicAnimator.addBehavior(collision)
        
        let gravity = UIGravityBehavior(items: [contentView])
        gravity.gravityDirection = CGVector(dx: -1, dy: 0)
        dynamicAnimator.addBehavior(gravity)
        
        let push = UIPushBehavior(items: [contentView], mode: .Instantaneous)
        push.magnitude = 0.0
        push.angle = 0.0
        dynamicAnimator.addBehavior(push)
        
        
    }
}
