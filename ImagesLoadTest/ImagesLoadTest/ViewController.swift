//
//  ViewController.swift
//  ImagesLoadTest
//
//  Created by Vipul on 05/07/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var refresher:UIRefreshControl!
    
    let viewModel = CollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareView()
    }
    
    private func prepareView() {
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(refreshCollectionData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        
        self.view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
        
        viewModel.callRequest(APIRouter.getImages)
        
        viewModel.reloadDataSuccessfully =  {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
                self.collectionView!.refreshControl?.endRefreshing()
                self.refresher.endRefreshing()
            }
        }
        
        viewModel.showError = { errorMessage in
            self.activityIndicator.stopAnimating()
            self.showAlert(message: errorMessage)
            self.collectionView!.refreshControl?.endRefreshing()
        }
    }
    
    @objc func refreshCollectionData() {
        self.collectionView!.refreshControl?.beginRefreshing()
        viewModel.callRequest(APIRouter.getImages)
    }
}


// MARK: - Flow layout delegate

extension ViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let objImage = viewModel.arrayImagesToLoadViewModels[indexPath.item].image
        if let height = objImage?.size.height {
            return height / 2.0
        }
        return 0.0
    }
}

// MARK: Data source

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrayImagesToLoadViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let objImage = viewModel.arrayImagesToLoadViewModels[indexPath.item]
        cell.imageInfo = objImage
        return cell
    }
}

extension UIViewController {
    func showAlert(message : String){
        let alertMessage  = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertOKAction = UIAlertAction(title: "Ok", style: .default, handler: { (action : UIAlertAction) in
            alertMessage.dismiss(animated: true, completion:nil)
        })
        
        alertMessage.addAction(alertOKAction)
        self.present(alertMessage, animated: true, completion: nil)
    }
}


