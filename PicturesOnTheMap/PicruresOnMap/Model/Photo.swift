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
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_n"
        case photoID = "id"
        case latitude
        case longitude
    }
}


