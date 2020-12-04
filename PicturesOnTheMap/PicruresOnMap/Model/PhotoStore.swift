//
//  PhotoStore.swift
//  PicruresOnMap
//
//  Created by Abrar on 15/04/1442 AH.
//

import Foundation
import UIKit

//MARK: Error Handling

//Adding an error type to represent photo errors
enum PhotoError: Error {
    case imageCreationError
    case missingImageURL
}

//MARK: Photo Handling

//Initiating the web service requests & Sending the Request
class PhotoStore {
    
    let imageStore = ImageStore()
    
    //Adding a URLSession property to hold instance of URLSession.
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    //MARK: - API Request
    
    //Start the web service request & transfer it to the server.
    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        
        let url = FlickrAPI.searchPhotosMethodURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            let result = self.processPhotosRequest(data: data, error: error)
            
            //Show Response
            print("JSON Response: \(String(data: data!, encoding: .utf8)!)")
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    //MARK: - Processing the web service data after API Request
    
    /*private*/ func processPhotosRequest(data: Data?,
                                      error: Error?) -> Result<[Photo], Error> {
        
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return FlickrAPI.photos(fromJSON: jsonData)
    }
    
    //MARK: - Image Request
    
    //Download image data
    func fetchImage(for photo: Photo,
                    completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        //Retrieve Image
        let photoKey = photo.photoID
        if let image = imageStore.image(forKey: photoKey) {
            
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
            
            return
            
        }
        
        guard let photoURL = photo.remoteURL else {
            completion(.failure(PhotoError.missingImageURL))
            return
        }
        
        let request = URLRequest(url: photoURL)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            //Convert into image
            let result = self.processImageRequest(data: data, error: error)
            
            //Add Image
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: photoKey)
            }
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        
        task.resume()
    }
    
    //MARK: - Processing the image data into an image after Image Request

    /*private*/ func processImageRequest(data: Data?,
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


