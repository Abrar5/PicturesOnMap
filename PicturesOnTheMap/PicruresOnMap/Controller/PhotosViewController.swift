//
//  PhotosViewController.swift
//  PicruresOnMap
//
//  Created by Abrar on 15/04/1442 AH.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initiating the web service request
        store.fetchPhotos {
            (photosResult) in
            
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                
                //Showing the first photo
//                if let firstPhoto = photos.first {
//                    self.updateImageView(for: firstPhoto)
//                }
                
            case let .failure(error):
                print("Error fetching photos: \(error)")
            }
        }
    }
    

}
