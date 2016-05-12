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
    
    private var myContext = 0
    private var alertView : AlertView? {
        didSet{
            if let oldValue = oldValue {
                dynamicAnimator.removeAllBehaviors()
                
                oldValue.removeObserver(self, forKeyPath: "center", context: &myContext)
                
                oldValue.removeFromSuperview()
            }
            
            if let newValue = alertView {
                view.addSubview(newValue)
                let snapBehavior = UISnapBehavior(item: newValue, snapToPoint: view.center)
                dynamicAnimator.addBehavior(snapBehavior)
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(alertViewTapped(_:)))
                newValue.addGestureRecognizer(tapGesture)
                
                newValue.addObserver(self, forKeyPath: "center", options: .New, context: &myContext)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        
        alertView = nil;
    }
    
    @IBAction func showAlert(sender: UIButton) {
        self.alertView = createAlertView()
    }
    
    func createAlertView() -> AlertView {
        let frame = CGRect(x: self.view.center.x - 50, y: -100, width: 150, height: 100)
        let view = AlertView(frame: frame)
        view.backgroundColor = UIColor.orangeColor()
        
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
                self.alertView = nil
            }
        }
    }
}

class AlertView : UIView {
    weak var gravity : UIGravityBehavior?
    var isRemoving  = false
}