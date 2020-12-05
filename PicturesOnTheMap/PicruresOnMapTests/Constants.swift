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
           "datetaken": dateString
        ]
    
    
    static let photosDictionary = ["photo" : [validPhotoDictionary]]
    static let flickrDictionary = ["photos" : photosDictionary]
    
    static let jsonData = try! JSONSerialization.data(withJSONObject: flickrDictionary)
    
    static let jsonData1 = """
        {
            "id": "50674085742",
            "owner": "48945861@N06",
            "secret": "8bf343e9d6",
            "server": "65535",
            "farm": 66,
            "title": "Uplifting!",
            "ispublic": 1,
            "isfriend": 0,
            "isfamily": 0,
            "datetaken": "2020-11-30 07:57:55",
            "datetakengranularity": "0",
            "datetakenunknown": "0",
            "latitude": 0,
            "longitude": 0,
            "accuracy": 0,
            "context": 0,
            "url_h": "https://live.staticflickr.com/65535/50674085742_65c05bf154_h.jpg",
            "height_h": 1067,
            "width_h": 1600
        }
 """.data(using: .utf8)
    
    
}

