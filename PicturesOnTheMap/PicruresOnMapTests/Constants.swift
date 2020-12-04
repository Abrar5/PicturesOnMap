//
//  Constants.swift
//  PicruresOnMapTests
//
//  Created by Abrar on 18/04/1442 AH.
//

import Foundation
@testable import PicruresOnMap

enum Constants {
    
    //MARK: - API
    
    static let urlString = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=b2f9f1783412cdf8fe6aef63e11ca7fd&safe_search=1&has_geo=1&lat=24.853962867051948&lon=46.7134110745225&radius=0.5&extras=url_n%2C+geo%2C+date_taken&per_page=30&format=json&nojsoncallback=1"
    
    static let apiURL = URL(string: urlString)!
    
    //MARK: - PHOTO
    
    static let title = ""
    static let remoteURLString = "https://live.staticflickr.com/65535/49164363111_3ba3bed23c_n.jpg"
    static let remoteURL = URL(string: remoteURLString)!
    static let photoID = "49164363111"
    static let latitude = "24.840222"
    static let longitude = "46.732455"
    
    //MARK: - Date
    
    static let dateString = "2019-11-28"
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let date = dateFormatter.date(from: dateString)!
    
    //an image that is 0.0 km far & taken about 0 month ago
    static let photoTestData = Photo(title: title,
                                     remoteURL: remoteURL,
                                     photoID: photoID,
                                     latitude: latitude,
                                     longitude: longitude,
                                     dateTaken: date)
    
    
    
    //MARK: - JSON
    
    static let validPhotoDictionary: [String:Any] =
        [  "title": "",
           "url_n": remoteURLString,
           "id": photoID,
           "latitude": latitude,
           "longitude": longitude,
           "datetaken": date
        ]
    
    static let photosDictionary = ["photo" : [validPhotoDictionary]]
    static let flickrDictionary = ["photos" : photosDictionary]
    
    static let jsonData = try! JSONSerialization.data(withJSONObject: flickrDictionary)
    
    
}

