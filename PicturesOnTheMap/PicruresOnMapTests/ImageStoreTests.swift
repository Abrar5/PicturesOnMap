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
   let realUIImage = UIImage(contentsOfFile: Constants.photoTestData.remoteURL!.path)
    
    //Test if the generated image URL in Ducument Directory is  different than its URL.
    func testImageURL(){
       let imageURL = imageStoreObject.imageURL(forKey: Constants.remoteURLString)
        XCTAssertNotNil(imageURL)
        XCTAssertNotEqual(imageURL,Constants.remoteURL)
    }
 
}
