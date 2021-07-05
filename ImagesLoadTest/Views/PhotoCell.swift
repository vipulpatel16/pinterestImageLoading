//
//
//  ViewController.swift
//  ImagesLoadTest
//
//  Created by Vipul on 05/07/21.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLikes: UILabel!
    
    var imageInfo : ImageModel! {
        didSet {
            self.imageView.image = imageInfo.image
            self.labelName.text = imageInfo.userName
            self.labelLikes.text = "\(imageInfo.numberOfLikes ?? 0)"
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
