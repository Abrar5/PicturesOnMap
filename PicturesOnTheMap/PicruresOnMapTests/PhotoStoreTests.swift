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
    
    //MARK: - Test Process Photos Request
    
    func testProcessPhotosRequest() {
        let photoResult = photoStoreObject.processPhotosRequest(data: Constants.jsonData,
                                                                error:nil)
        XCTAssertNotNil(photoResult)
        
                switch photoResult {
                case .success(let Photos):
                    XCTAssert(Photos.count == 1)
                    let thePhoto = Photos[0]
                    XCTAssertEqual(thePhoto.title, Constants.title)
                    XCTAssertEqual(thePhoto.remoteURL, Constants.remoteURL)
                    XCTAssertEqual(thePhoto.photoID, Constants.photoID)
                    XCTAssertEqual(thePhoto.latitude, Constants.latitude)
                    XCTAssertEqual(thePhoto.longitude, Constants.longitude)
                   // XCTAssertEqual(thePhoto.dateTaken, Constants.date)
                    XCTAssertNotNil(thePhoto.dateTaken)
                    
                case .failure(let error):
                    XCTFail("Result contains Failure due to\(error)")

                }
    }
    
    //MARK: - Test Process Images Request
    
    func testProcessImageRequest() {
        let imageResult = photoStoreObject.processImageRequest(data: Constants.jsonData,
                                                               error: nil)
        XCTAssertNotNil(imageResult)
        print("result \(imageResult)")
    }
    
}
