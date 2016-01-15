//
//  BounceContentViewController.swift
//  DemoDynamicCollectionView
//
//  Created by wizard on 1/15/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

protocol BounceContentDelegate {
    func bounceButtonTapped()
}

class BounceContentViewController : UIViewController {
    
    var delegate : BounceContentDelegate?
    
    @IBAction func bounceButtonTapped(sender: UIBarButtonItem) {
        delegate?.bounceButtonTapped()
    }
}
