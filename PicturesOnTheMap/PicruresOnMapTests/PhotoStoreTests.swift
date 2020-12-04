//
//  PhotoStoreTest.swift
//  PicruresOnMapTests
//
//  Created by Abrar on 19/04/1442 AH.
//

import XCTest
@testable import PicruresOnMap

class PhotoStoreTests: XCTestCase {
    
    let photoStoreObject = PhotoStore()
    
    //MARK: -Test Web Service Request
    
    func testFetchPhotos() {
        
        let completionExpectation = expectation(description: "Execute completion closure.")
        
        //Test Web Service Request
        photoStoreObject.fetchPhotos {
            (photosResult) -> Void in
            
            XCTAssertEqual(OperationQueue.current,
                           OperationQueue.main,
                           "Completion handler should run on the main thread; it did not.")
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    //MARK: -Test Image Request
    
    func testFetchImage() {
        
        let completionExpectation = expectation(description: "Execute completion closure.")
        
        //Test Web Service Request
        photoStoreObject.fetchImage(for: Constants.photoTestData) {
            (photosResult) -> Void in
            
            XCTAssertEqual(OperationQueue.current,
                           OperationQueue.main,
                           "Completion handler should run on the main thread; it did not.")
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    //MARK: -
    func testProcessPhotosRequest() {
        
    }
    
}
