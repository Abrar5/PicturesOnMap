//
//  FlickerAPITests.swift
//  PicruresOnMapTests
//
//  Created by user on 18/04/1442 AH.
//

import XCTest
@testable import PicruresOnMap

class MapTests: XCTestCase {

    func testMapResults() {
        
        let mapObject = MapViewController()
        
        XCTAssertNotNil(mapObject.locationManager)
        
        XCTAssertNotNil(MapViewController.latitudeString)
        XCTAssertNotNil(MapViewController.longitudeString)
   }

}
