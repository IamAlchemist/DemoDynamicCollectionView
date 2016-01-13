//
//  NewtownianLayoutAttributes.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/12/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class NewtownianLayoutAttributes : UICollectionViewLayoutAttributes {
    var id : Int = 0
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let newValue = super.copyWithZone(zone) as! NewtownianLayoutAttributes
        newValue.id = id
        return newValue
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if super.isEqual(object) {
            if let attributeObject = object as? NewtownianLayoutAttributes {
                if attributeObject.id == id {
                    return true
                }
            }
        }
        
        return false
    }
}
