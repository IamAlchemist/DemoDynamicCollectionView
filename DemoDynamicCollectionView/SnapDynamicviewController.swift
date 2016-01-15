//
//  SnapDynamicviewController.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/15/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit
import Foundation

class SnapDynamicViewController : UIViewController {
    
    var dynamicAnimator : UIDynamicAnimator!
    
    private var myContext = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
    }
    
    @IBAction func showAlert(sender: UIButton) {
        let alertView = createAlertView()
        view.addSubview(alertView)
        
        let snapBehavior = UISnapBehavior(item: alertView, snapToPoint: view.center)
        dynamicAnimator.addBehavior(snapBehavior)
    }
    
    func createAlertView() -> UIView {
        let frame = CGRect(x: self.view.center.x - 50, y: -100, width: 150, height: 100)
        let view = AlertView(frame: frame)
        view.backgroundColor = UIColor.orangeColor()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "alertViewTapped:")
        view.addGestureRecognizer(tapGesture)
        
        view.addObserver(self, forKeyPath: "center", options: .New, context: &myContext)
        return view
    }
    
    func alertViewTapped(gesture : UITapGestureRecognizer) {
        dynamicAnimator.removeAllBehaviors()
        
        guard let gestureView = (gesture.view as? AlertView) else { return }
        
        let gravity = UIGravityBehavior(items: [gestureView])
        gestureView.gravity = gravity
        
        dynamicAnimator.addBehavior(gravity)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &myContext {
            guard let centerValue = change![NSKeyValueChangeNewKey]! as? NSValue  else {return}
            guard let alertView = object as? AlertView else {return}
            
            let center = centerValue.CGPointValue()
            let minY = center.y - 50
            let bottomOfContainer = CGRectGetMaxY(view.bounds)
            if minY > bottomOfContainer && !alertView.isRemoving {
                alertView.isRemoving = true
                if let gravity = alertView.gravity {
                    dynamicAnimator.removeBehavior(gravity)
                }
                
                alertView.removeObserver(self, forKeyPath: "center")
                alertView.removeFromSuperview()
            }
        }
    }
}

class AlertView : UIView {
    weak var gravity : UIGravityBehavior?
    var isRemoving  = false
}