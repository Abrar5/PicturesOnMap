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

        testSetImage()
        let savedImage = imageStoreObject.image(forKey: Constants.photoID)

        XCTAssertNotNil(savedImage)
        //URL on disk is longer than the real URL
        XCTAssertNotEqual(savedImage, UIImage(data: imageData)!)
    }

    
    //MARK: - Test if the generated image URL in Ducument Directory is  different than its URL.
    
    func testImageURL(){
        let imageURL = imageStoreObject.imageURL(forKey: Constants.photoID)
        
        XCTAssertNotNil(imageURL)
        
        //URL on disk is longer than the real URL
        XCTAssertNotEqual(imageURL,Constants.remoteURL)
    }
}
