//
//  FlickerAPITests.swift
//  PicruresOnMapTests
//
//  Created by Abrar on 18/04/1442 AH.
//

import XCTest
@testable import PicruresOnMap

class MapViewControllerTests: XCTestCase {
    
    let mapObject = MapViewController()

    //MARK: - Test if the variables have a value
    
    func testMapVariables() {
        
        XCTAssertNil(mapObject.mapView)
        XCTAssertNotNil(mapObject.locationManager)
        
        XCTAssertNotNil(MapViewController.latitudeString)
        XCTAssertNotNil(MapViewController.longitudeString)
        
    }
        
}
