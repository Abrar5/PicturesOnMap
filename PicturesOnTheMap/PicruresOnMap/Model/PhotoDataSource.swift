//
//  PhotoDataSource.swift
//  PicruresOnMap
//
//  Created by Abrar on 15/04/1442 AH.
//

import UIKit

private let reuseIdentifier = "PhotoCollectionViewCell"

class PhotoDataSource: NSObject, UICollectionViewDataSource {
    
    var photos = [Photo]()

    // MARK: - UICollectionViewDataSource

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
    
    cell.updateActivityIndicator(displaying: nil)
    cell.timingLabel.text = ""
    cell.distanceLabel.text = ""
    
        return cell
    }

}
