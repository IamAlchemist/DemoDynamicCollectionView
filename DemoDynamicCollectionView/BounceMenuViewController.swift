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
    var pushBehavior : UIPushBehavior!
    var gravityBehavior : UIGravityBehavior!
    var attachmentBehavior : UIAttachmentBehavior!
    
    var leftScreenEdgeGestureRecognizer : UIScreenEdgePanGestureRecognizer!
    var rightScreenEdgeGestureRecognizer : UIScreenEdgePanGestureRecognizer!
    
    var isMenuOpen = false
    
    var anchorDeltaX : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftScreenEdgeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "handleScreenEdgePan:")
        leftScreenEdgeGestureRecognizer.edges = .Left
        leftScreenEdgeGestureRecognizer.delegate = self
        view.addGestureRecognizer(leftScreenEdgeGestureRecognizer)
        
        rightScreenEdgeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "handleScreenEdgePan:")
        rightScreenEdgeGestureRecognizer.edges = .Right
        rightScreenEdgeGestureRecognizer.delegate = self
        view.addGestureRecognizer(rightScreenEdgeGestureRecognizer)
        
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

        gravityBehavior = UIGravityBehavior(items: [contentView])
        gravityBehavior.gravityDirection = CGVector(dx: -1, dy: 0)
        dynamicAnimator.addBehavior(gravityBehavior)

        pushBehavior = UIPushBehavior(items: [contentView], mode: .Instantaneous)
        pushBehavior.magnitude = 0.0
        pushBehavior.angle = 0.0
        dynamicAnimator.addBehavior(pushBehavior)

        let itemBehavior = UIDynamicItemBehavior(items: [contentView])
        itemBehavior.elasticity = 0.7
        dynamicAnimator.addBehavior(itemBehavior)
    }
    
    func handleScreenEdgePan(gestureRecognizer : UIScreenEdgePanGestureRecognizer){
        let location = gestureRecognizer.locationInView(view)
        var anchor = location
        anchor.y = CGRectGetMidY(contentView.frame)
        
        switch gestureRecognizer.state {
        case .Began:
            anchorDeltaX = location.x - contentView.center.x
            anchor.x = location.x - anchorDeltaX
            dynamicAnimator.removeBehavior(gravityBehavior)
            attachmentBehavior = UIAttachmentBehavior(item: contentView, attachedToAnchor: anchor)
            attachmentBehavior.length = 0.0
            dynamicAnimator.addBehavior(attachmentBehavior)
        case .Changed:
            anchor.x = location.x - anchorDeltaX
            attachmentBehavior.anchorPoint = anchor
            print("anchor : \(anchor), frame: \(contentView.center)")
        case .Ended:
            dynamicAnimator.removeBehavior(attachmentBehavior)
            attachmentBehavior = nil
            
            let velocity = gestureRecognizer.velocityInView(view)
            
            if velocity.x > 0 {
                isMenuOpen = true
                gravityBehavior.gravityDirection = CGVector(dx: 1,dy: 0)
            }
            else {
                isMenuOpen = false
                gravityBehavior.gravityDirection = CGVector(dx: -1, dy: 0)
            }
            
            dynamicAnimator.addBehavior(gravityBehavior)
            
            pushBehavior.pushDirection = CGVector(dx: velocity.y / 10, dy: 0)
            pushBehavior.active = true
            
        default:
            break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if segue.identifier == "contentViewController" {
            ((segue.destinationViewController as? UINavigationController)?.topViewController as? BounceContentViewController)?.delegate = self
        }
    }
}

extension BounceMenuViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if gestureRecognizer == leftScreenEdgeGestureRecognizer && isMenuOpen == false {
            return true
        }
        else if gestureRecognizer == rightScreenEdgeGestureRecognizer && isMenuOpen == true {
            return true
        }
        
        return false
    }
}

extension BounceMenuViewController : BounceContentDelegate {
    func bounceButtonTapped() {
        pushBehavior?.pushDirection = CGVector(dx: 35, dy: 0)
        pushBehavior?.active = true
    }
}
