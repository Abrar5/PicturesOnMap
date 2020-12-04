//
//  ImageStoreTests.swift
//  PicruresOnMapTests
//
//  Created by Abrar on 19/04/1442 AH.
//

import XCTest
@testable import PicruresOnMap

class ImageStoreTests: XCTestCase {
    
    let imageStoreObject = ImageStore()
    let cache = NSCache<NSString,UIImage>()
    
    let imageData =  try! Data(contentsOf: Constants.remoteURL)
    
    //MARK: - Test add image to disk function
    
    func testSetImage() {
        
        let setImage: () = imageStoreObject.setImage(UIImage(data: imageData)!, forKey: Constants.photoID)
        
        XCTAssertNotNil(setImage)
        
    }
    
    //MARK: - Test retrieve image from disk function
    
    func testImage() {
        
        //1. Assume the image is not saved before
        let notSavedImage = imageStoreObject.image(forKey: Constants.photoID)
        XCTAssertNil(notSavedImage)
        
        //2. Assume the image is saved
        testSetImage()
        let savedImage = imageStoreObject.image(forKey: Constants.photoID)

        XCTAssertNotNil(savedImage)
        //URL on disk is longer than the real URL
        XCTAssertNotEqual(savedImage, UIImage(data: imageData)!)
    }
    
    //MARK: - Test deleting image from disk function
    
    func testDeleteImage() {
        
        imageStoreObject.deleteImage(forKey: Constants.photoID)
        
        //Make sure pic is deleted from disk
        if cache.object(forKey: Constants.photoID as NSString) != nil {
            XCTFail("This image is not deleted yet!")
        }
        
    }
    
    //MARK: - Test if the generated image URL in Ducument Directory is  different than its URL.
    
    func testImageURL(){
        let imageURL = imageStoreObject.imageURL(forKey: Constants.photoID)
        
        XCTAssertNotNil(imageURL)
        
        //URL on disk is longer than the real URL
        XCTAssertNotEqual(imageURL,Constants.remoteURL)
    }
}
