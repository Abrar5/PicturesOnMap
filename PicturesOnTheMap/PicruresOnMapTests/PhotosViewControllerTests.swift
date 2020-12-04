//
//  PhotosVCTests.swift
//  PicruresOnMapTests
//
//  Created by Abrar on 18/04/1442 AH.
//

import XCTest
@testable import PicruresOnMap

class PhotosViewControllerTests: XCTestCase {
    
    let photoObject = PhotosViewController()

    //MARK: - Test if the variables have a value
    
    func testPhotosVariables() {
        XCTAssertNil(photoObject.collectionView)
        XCTAssertNil(photoObject.store)
        
        XCTAssertNotNil(photoObject.photoDataSource)
    }
    
    //MARK: - Test Distance Method
    
    func testDistanceResult() {
        let distance = photoObject.calculateDistance(photo: Constants.photoTestData)
       
        XCTAssertNotNil(distance)
        XCTAssertGreaterThan(distance, -1)
    }
    
    //MARK: - Test Time Difference Method
    
    func testTimeDurationResult() {
        let timeDuration = photoObject.calculateTimePeriod(photo: Constants.photoTestData)
        
        XCTAssertNotNil(timeDuration)
        XCTAssertEqual(timeDuration, "About 1y 0mo")
    }
    
}
