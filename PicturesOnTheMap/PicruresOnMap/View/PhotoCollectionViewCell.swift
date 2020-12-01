//
//  PhotoCollectionViewCell.swift
//  PicruresOnMap
//
//  Created by Abrar on 15/04/1442 AH.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var timingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    //Control Activity Indicator Appearance
    func updateActivityIndicator(displaying image: UIImage?) {
        
        if let imageToDisplay = image {
            activityIndicator.stopAnimating()
            imageView.image = imageToDisplay
       
        } else {
            activityIndicator.startAnimating()
            imageView.image = nil
        }
        
    }
    
    
}
