//
//  Constants.swift
//  PicruresOnMapTests
//
//  Created by Abrar on 18/04/1442 AH.
//

import Foundation
@testable import PicruresOnMap

enum Constants {
    
    //MARK: - PHOTO Example
    
    static let title = ""
    static let remoteURLString = "https://live.staticflickr.com/65535/49164363111_3ba3bed23c_n.jpg"
    static let remoteURL = URL(string: remoteURLString)!
    static let photoID = "49164363111"
    static let latitude = "24.840222"
    static let longitude = "46.732455"
    
    //MARK: - Date Converter
    
    static let dateString = "2019-11-28 20:17:33"
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")!
        return formatter
    }()
    
    static let date = dateFormatter.date(from: dateString)!
    
    //MARK: - Image Example
    
    //an image that is 0.0 km far & taken about 0 month ago
    static let photoTestData = Photo(title: title,
                                     remoteURL: remoteURL,
                                     photoID: photoID,
                                     latitude: latitude,
                                     longitude: longitude,
                                     dateTaken: date)
    
    //MARK: - JSON Response Example
    
    static let jsonData = """
{
  "photos": {
    "page": 1,
    "pages": 10984,
    "perpage": 30,
    "total": "329494",
    "photo": [
    {"id":"\(photoID)",
    "title":"\(title)",
    "date_taken":"\(dateString)",
    "latitude":"\(latitude)",
    "longitude":"\(longitude)",
    "url_n":"\(remoteURL)"}]},
  "stat": "ok"
}
""".data(using: .utf8)!
    
}

