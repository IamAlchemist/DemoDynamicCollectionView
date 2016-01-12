//
//  NewtownianCell.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/6/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class NewtownianCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configWithImageName(imageName : String){
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        backgroundColor = UIColor.orangeColor()
        imageView.image = UIImage(named: imageName)
    }
}
