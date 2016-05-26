//
//  DCCollectionView.swift
//  DemoCollectionView
//
//  Created by Wizard Li on 5/26/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class DCCollectionView : UICollectionView {
    override var dataSource: UICollectionViewDataSource? {
        didSet {
            print("data source \(dataSource), \(unsafeAddressOf(self))")
        }
    }
}
