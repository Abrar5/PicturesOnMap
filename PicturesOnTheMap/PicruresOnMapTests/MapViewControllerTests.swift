//
//  FlickerAPITests.swift
//  PicruresOnMapTests
//
//  Created by user on 18/04/1442 AH.
//

import XCTest
@testable import PicruresOnMap

class MapViewControllerTests: XCTestCase {
    
    let mapObject = MapViewController()

    func testMapVariables() {
        
        XCTAssertNil(mapObject.mapView)
        XCTAssertNotNil(mapObject.locationManager)
        
        XCTAssertNotNil(MapViewController.latitudeString)
        XCTAssertNotNil(MapViewController.longitudeString)
        
    }
        
}
