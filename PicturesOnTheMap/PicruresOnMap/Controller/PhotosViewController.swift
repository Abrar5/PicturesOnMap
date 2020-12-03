//
//  PhotosViewController.swift
//  PicruresOnMap
//
//  Created by Abrar on 15/04/1442 AH.
//

import UIKit
import CoreLocation

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        //Initiating the web service request
        store.fetchPhotos {
            (photosResult) in
            
            //Updating the collection view with the web service data
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                self.photoDataSource.photos = photos
                
            case let .failure(error):
                print("Error fetching photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    // MARK: - UICollectionViewDelegate
    
    //Fetching the cell’s image
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        // Download the image data
        store.fetchImage(for: photo) { (result) -> Void in
            
            // the most recent index path for the photo
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
                  case let .success(image) = result else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            // When the request finishes, find the current cell for this photo
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                //display image
                cell.updateActivityIndicator(displaying: image)
                
                //Calculate the Date the pic was taken at:
                guard let imageDateTaken = photo.dateTaken else {
                    return
                }
                
                print(imageDateTaken)
      
                let today = Date()
       
                //Display The date pic was taken on
                // to describe the duration between `today` and `pic taken date`
                let dateFormatter: DateComponentsFormatter = {
                    let formatter = DateComponentsFormatter()
                    formatter.allowedUnits = [.year, .month]
                    formatter.includesApproximationPhrase = true
                    return formatter
                }()
                
                let dateDescription = dateFormatter.string(from: imageDateTaken, to: today)
                print(dateDescription!)
                
                cell.timingLabel.text = "\(String(describing: dateDescription!))"
                
                //Display the distance
                guard let imageLatitude = photo.latitude,
                      let imageLongitude = photo.longitude else {
                    return
                }
                
                let coordinate1 = CLLocation(latitude: Double(MapViewController.latitudeString)!, longitude: Double(MapViewController.longitudeString)!)
                
                let coordinate2 = CLLocation(latitude: Double(imageLatitude)!, longitude: Double(imageLongitude)!)

                let distanceInKM = coordinate1.distance(from: coordinate2) / 1000
                                
                cell.distanceLabel.text = "\(Int(round(distanceInKM))) km"
                
            }
        }
    }
    

}


