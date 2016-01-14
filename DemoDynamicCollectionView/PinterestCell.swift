//
//  PinterestCell.swift
//  DemoDynamicCollectionView
//
//  Created by wizard on 1/13/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class PinterestCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
}

extension PinterestCell {
    func configCell(photo: Photo){
        captionLabel.text = photo.caption
        commentLabel.text = photo.comment
        imageView.image = photo.image
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}

extension PinterestCell {
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        imageHeightConstraint.constant = (layoutAttributes as! PinterestViewLayoutAttributes).photoHeight
    }
}