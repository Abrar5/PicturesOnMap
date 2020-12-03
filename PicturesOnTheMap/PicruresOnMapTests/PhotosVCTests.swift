//
//  PhotosVCTests.swift
//  PicruresOnMapTests
//
//  Created by Abrar on 18/04/1442 AH.
//

import XCTest
@testable import PicruresOnMap

class PhotosVCTests: XCTestCase {
    
    let photoObject = PhotosViewController()

    //Test if the variables have a value
    func testPhotosVariables() {
        XCTAssertNil(photoObject.collectionView)
        XCTAssertNil(photoObject.store)
        
        XCTAssertNotNil(photoObject.photoDataSource)
    }
    
    //Test Distance Method
    func testDistanceResult() {
        let distance = photoObject.calculateDistance(photo: Constants.photoTestData)
       
        XCTAssertNotNil(distance)
        XCTAssertGreaterThan(distance, -1)
    }
    
    func testTimeDurationResult() {
        let timeDuration = photoObject.calculateTimePeriod(photo: Constants.photoTestData)
        
        XCTAssertNotNil(timeDuration)
        XCTAssertEqual(timeDuration, "About 1y 0mo")
    }
    
}
