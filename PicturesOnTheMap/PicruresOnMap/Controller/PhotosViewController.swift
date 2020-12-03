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
        
        //MARK: - Handling Photo
        let photo = photoDataSource.photos[indexPath.row]
        
        //Download the image data
        store.fetchImage(for: photo) { (result) -> Void in
            
            //the most recent index path for the photo
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
                  case let .success(image) = result else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            //MARK: - Displaying Information on Their Specific Cell
            
            // When the request finishes, find the current cell for this photo
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                
                //(1)Display Image
                cell.updateActivityIndicator(displaying: image)
                
                //(2)Display Distance Amount
                let distanceInK = self.calculateDistance(photo: photo)
                
                cell.distanceLabel.text = "\(distanceInK) km"
                
                //(3)Display Duration Amount
                let dateDescription = self.calculateTimePeriod(photo: photo)
                
                cell.timingLabel.text = "\(dateDescription)"
                
                
            }
        }
    }
    
    //MARK: - Calculate Distance
    
    func calculateDistance(photo: Photo) -> Double {
        
        //Display the distance
        guard let imageLatitude = photo.latitude,
              let imageLongitude = photo.longitude else {
            print("Error Calculating Distance!")
            return 0.0
        }
        
        let coordinate1 = CLLocation(latitude: Double(MapViewController.latitudeString)!,
                                     longitude:Double(MapViewController.longitudeString)!)
        
        let coordinate2 = CLLocation(latitude: Double(imageLatitude)!,
                                     longitude: Double(imageLongitude)!)
        
        let distanceInKM = coordinate1.distance(from: coordinate2) / 1000
        print(distanceInKM)

        //Show only 1 digit after the decimal & reound it
        return Double(round(distanceInKM*10)/10)
        
    }
    
    //MARK: - Calculate The Time Period between Today & Date pic taken on
    
    func calculateTimePeriod(photo: Photo) -> String {
        
        //Calculate the Date the pic was taken at:
        guard let imageDateTaken = photo.dateTaken else {
            return "Error Calculating Period!"
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
        
        return String(describing: dateDescription!)
        
    }
    
}


