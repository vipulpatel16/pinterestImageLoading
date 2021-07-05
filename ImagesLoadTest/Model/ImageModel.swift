//
//  ImageModel.swift
//  ImagesLoadTest
//
//  Created by Vipul on 05/07/21.
//

import Foundation
import UIKit

struct ImageModel {
    let imageURL: String
    let userName: String
    let numberOfLikes: Int?
    var image: UIImage?
    
    init(imageURL: String, userName: String, numberOfLikes: Int) {
        self.imageURL = imageURL
        self.userName = userName
        self.numberOfLikes = numberOfLikes
    }
    
    init(imageData : ImageData) {
        self.imageURL = imageData.urls?.regular ?? ""
        self.userName = imageData.user?.name ?? ""
        self.numberOfLikes = imageData.likes ?? 0
    }
}
