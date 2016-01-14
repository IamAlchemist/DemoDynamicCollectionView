//
//  Photo.swift
//  DemoDynamicCollectionView
//
//  Created by wizard on 1/14/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class Photo {
    var caption : String
    var comment : String
    var image : UIImage
    
    init(caption: String, comment: String, image: UIImage) {
        self.caption = caption
        self.comment = comment
        self.image = image
    }
    
    convenience init(dictionary: NSDictionary){
        let caption = dictionary["Caption"] as! String
        let comment = dictionary["Comment"] as! String
        let photo = dictionary["Photo"] as! String
        let image = UIImage(named: photo)
        self.init(caption: caption, comment: comment, image: image!)
    }
    
    func heightForComment(font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: comment).boundingRectWithSize(
            CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font],
            context: nil)
        
        return ceil(rect.height)
    }
    
    class func allPhotos() -> [Photo] {
        var photos = [Photo]()
        
        guard let URL = NSBundle.mainBundle()
            .URLForResource("Photos", withExtension: "plist")
            else { return photos }
        
        guard let photosFromPlist = NSArray(contentsOfURL: URL)
            else { return photos }
        
        for dictionary in photosFromPlist {
            photos.append(Photo(dictionary: dictionary as! NSDictionary))
        }
        
        return photos
    }
}
