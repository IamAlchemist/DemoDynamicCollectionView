//
//  BounceMenuViewController.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/15/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class BounceMenuViewController : UIViewController{
    
    @IBOutlet weak var contentView: UIView!
    
    var dynamicAnimator : UIDynamicAnimator!
    var pushBehavior : UIPushBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.layer.shadowColor = UIColor.orangeColor().CGColor
        contentView.layer.shadowOpacity = 1.0
        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).CGPath
        contentView.layer.shadowOffset = CGSizeZero
        contentView.layer.shadowRadius = 5.0
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
    }
    
    override func viewDidAppear(animated: Bool) {
        dynamicAnimator.removeAllBehaviors()
        
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
        pushBehavior = push

        let itemBehavior = UIDynamicItemBehavior(items: [contentView])
        itemBehavior.elasticity = 0.7
        itemBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(itemBehavior)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if segue.identifier == "contentViewController" {
            ((segue.destinationViewController as? UINavigationController)?.topViewController as? BounceContentViewController)?.delegate = self
        }
    }
}

extension BounceMenuViewController : BounceContentDelegate {
    func bounceButtonTapped() {
        pushBehavior?.pushDirection = CGVector(dx: 35, dy: 0)
        pushBehavior?.active = true
    }
}
