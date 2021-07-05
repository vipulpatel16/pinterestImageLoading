//
//  CollectionViewModel.swift
//  ImagesLoadTest
//
//  Created by Vipul on 05/07/21.
//

import Foundation
import Alamofire
import UIKit

class CollectionViewModel {

    var arrayImagesViewModels: [ImageModel] = [] {
        didSet {
            self.fetchPhoto()
        }
    }
    
    var arrayImagesToLoadViewModels: [ImageModel] = []
    
    var reloadDataSuccessfully: (() -> Void)?
    var showError: ((String) -> Void)?
    
    func callRequest(_ router: APIRouter) {
        AF.request(router.path).response { response in
            if let data = response.data {
                do {
                    let imageResponse = try JSONDecoder().decode([ImageData].self, from:data)
                    print(imageResponse)
                    self.arrayImagesViewModels = imageResponse.map({ ImageModel(imageData: $0) })
                }catch let err {
                    print(err.localizedDescription)
                    self.showError?(err.localizedDescription)
                }
            }else{
                self.showError?(response.error?.localizedDescription ?? "api failed")
            }
        }
    }
    
    private func fetchPhoto() {
        let group = DispatchGroup()
        group.enter()
        self.arrayImagesViewModels.forEach { (imageDetail) in
            
            guard let imageData = try? Data(contentsOf: URL(string: imageDetail.imageURL)!) else {
                return
            }

            guard let image = UIImage(data: imageData) else {
                return
            }
            if var objImage = self.arrayImagesViewModels.filter({$0.imageURL == imageDetail.imageURL}).first {
                objImage.image = image
                self.arrayImagesToLoadViewModels.append(objImage)
            }
        }
        group.leave()

        group.notify(queue: .main) {
            self.reloadDataSuccessfully?()
        }
    }
}
