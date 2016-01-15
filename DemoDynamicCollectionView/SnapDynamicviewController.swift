//
//  SnapDynamicviewController.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/15/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class SnapDynamicViewController : UIViewController {
    
    var dynamicAnimator : UIDynamicAnimator!
    
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
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.orangeColor()
        return view
    }
}
