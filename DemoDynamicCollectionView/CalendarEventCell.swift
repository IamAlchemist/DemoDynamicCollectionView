//
//  CalendarEventCell.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/11/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class CalendarEventCell : UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0.7, alpha: 1).CGColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
}
