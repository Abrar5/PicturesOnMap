//
//  PhotoStore.swift
//  PicruresOnMap
//
//  Created by Abrar on 15/04/1442 AH.
//

import Foundation
import UIKit

//MARK: - Error Handling

//Adding an error type to represent photo errors
enum PhotoError: Error {
    case imageCreationError
    case missingImageURL
}

//MARK: - Photo Handling

//Initiating the web service requests & Sending the Request
class PhotoStore {
    
    //Adding a URLSession property to hold instance of URLSession.
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    //Start the web service request & transfer it to the server.
    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        
        let url = FlickrAPI.searchPhotosMethodURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            let result = self.processPhotosRequest(data: data, error: error)
            
            //Show Response
            print(String(data: data!,
                         encoding: .utf8)!)
            
                completion(result)
        }
        task.resume()
    }
    
    //Processing the web service data
    private func processPhotosRequest(data: Data?,
                                      error: Error?) -> Result<[Photo], Error> {
        
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return FlickrAPI.photos(fromJSON: jsonData)
    }
    
    //Download image data
    func fetchImage(for photo: Photo,
                    completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let photoURL = photo.remoteURL else {
            completion(.failure(PhotoError.missingImageURL))
            return
        }
        
        let request = URLRequest(url: photoURL)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            //Convert into image
            let result = self.processImageRequest(data: data, error: error)
            
            completion(result)
            
        }
        
        task.resume()
    }
    
    //processes the data from the request into an image
    private func processImageRequest(data: Data?,
                                     error: Error?) -> Result<UIImage, Error> {
        guard let imageData = data,
              let image = UIImage(data: imageData) else {
            
            //Couldn't create an image
            if data == nil {
                return .failure(error!)
            } else {
                return .failure(PhotoError.imageCreationError)
            }
        }
        
        return .success(image)
    }
    
    
}


