//
//  FlickrAPITests.swift
//  PicruresOnMapTests
//
//  Created by Abrar on 19/04/1442 AH.
//

import XCTest
@testable import PicruresOnMap

class FlickrAPITests: XCTestCase {
    
    func testVariable() {
        XCTAssertNotNil(FlickrAPI.searchPhotosMethodURL)
    }

    func testPhotos() {
        
        let photo = FlickrAPI.photos(fromJSON: Constants.jsonData)
        
        XCTAssertNotNil(photo)
        
        switch photo {
        case .success(let Photos):
            XCTAssert(Photos.count == 1)
            let thePhoto = Photos[0]
            XCTAssertEqual(thePhoto.title, Constants.title)
            XCTAssertEqual(thePhoto.remoteURL, Constants.remoteURL)
            XCTAssertEqual(thePhoto.photoID, Constants.photoID)
            XCTAssertEqual(thePhoto.latitude, Constants.latitude)
            XCTAssertEqual(thePhoto.longitude, Constants.longitude)
            XCTAssertEqual(thePhoto.dateTaken, Constants.date)
            XCTAssertNotNil(thePhoto.dateTaken)
            
        case .failure(let error):
            XCTFail("Result contains Failure due to\(error)")
        }
    
    }

}
