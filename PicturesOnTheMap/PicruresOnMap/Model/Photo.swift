//
//  Photo.swift
//  PicruresOnMap
//
//  Created by Abrar on 15/04/1442 AH.
//
import Foundation

class Photo : Codable {
    let title: String
    let remoteURL: URL?
    let photoID: String
    let latitude: String?
    let longitude: String?
    let dateTaken: Date?
    
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_n"
        case photoID = "id"
        case latitude
        case longitude
        case dateTaken = "datetaken"
    }
    
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        // Two Photos are the same if they have the same photoID
        return lhs.photoID == rhs.photoID
    }
}


