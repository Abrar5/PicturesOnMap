//
//  FakeFlickrURLProtocol.swift
//  PicruresOnMapTests
//
//  Created by Abrar on 21/04/1442 AH.
//

import Foundation
class FakeFlickrURLProtocol: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    //Produce the URL response and data, and send them
    override func startLoading() {
        print("Vending fake URL response.")
        client?.urlProtocol(self,
                            didReceive: Constants.okResponse,
                            cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self,
                            didLoad: Constants.jsonData)
        client?.urlProtocolDidFinishLoading(self)
    }
    
    //Perform cleanup
    override func stopLoading() {
        print("Done vending fake URL response.")
    }
    
}
