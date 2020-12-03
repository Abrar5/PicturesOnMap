//
//  FlickerAPI.swift
//  PicruresOnMap
//
//  Created by Abrar on 15/04/1442 AH.
//

import Foundation

// MARK: - End Point Method

enum EndPoint: String {
    case searchPhotosMethod = "flickr.photos.search"
}

// MARK: - URL

class FlickrAPI  {
    
    // MARK: - API Handling
    
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let apiKey = "b2f9f1783412cdf8fe6aef63e11ca7fd"
    
    //return a Flickr URL
    private static func flickrURL(endPoint: EndPoint,
                                  parameters: [String:String]?) -> URL {
        
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        //1. Adding the shared parameters to the URL
        let baseParams = [
            "method": endPoint.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": apiKey
        ]
        
        //Extract the URL from shared parameters
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        //2. Adding the additional parameters to the URL
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        return components.url!
        
    }
    
    //Exposing a URL for Search Photo Method
    static var searchPhotosMethodURL: URL {
        
        return flickrURL(endPoint: .searchPhotosMethod,
                         parameters: [
                            "extras": "url_n, geo, date_taken",
                            "per_page": "30",
                            "safe_search": "1",
                            "has_geo": "1",
                            "radius": "2",
                            "lat" : MapViewController.latitudeString,
                            "lon" : MapViewController.longitudeString
                         ])
    }
    
    //Decoding the JSON data
    static func photos(fromJSON data: Data) -> Result<[Photo], Error> {
        do {
            let decoder = JSONDecoder()
            
            //Adding a custom date decoding strategy
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let flickrResponse = try decoder.decode(FlickrResponse.self, from: data)
            
            //Filtering out photos with a missing URL
            let photos = flickrResponse.photosInfo.photos.filter { $0.remoteURL != nil }
            
            return .success(photos)
            
        } catch {
            print("Decoding Error", error)
            return .failure(error)
        }
        
    }
}

//Response Structures
struct FlickrResponse: Codable {
    let photosInfo: FlickrPhotosResponse
    
    enum CodingKeys: String, CodingKey {
        case photosInfo = "photos"
    }
}

struct FlickrPhotosResponse: Codable {
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
    
}


