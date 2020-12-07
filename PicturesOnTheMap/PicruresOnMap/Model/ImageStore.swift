//
//  ImageStore.swift
//  PicruresOnMap
//
//  Created by Abrar on 06/03/1442 AH.
//

import UIKit
class ImageStore {
    
    let cache = NSCache<NSString,UIImage>()
    
    //MARK: - ADD
    
    func setImage(_ image: UIImage, forKey key: String){
        
        DispatchQueue.main.async {
            self.cache.setObject(image, forKey: key as NSString)
            
            // Create full URL for image
            let url = self.imageURL(forKey: key)
            
            // Turn image into JPEG data
            if let data = image.jpegData(compressionQuality: 0.5) {
                // Write it to full URL
                try? data.write(to: url)
            }
            
        }
        
    }
    
    //MARK: - RETERIVE
    
    func image(forKey key: String) -> UIImage? {
        
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
        
    }

    //MARK: - Get Image URL
    
    //get a URL for a given image
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
        
    }
    
}
