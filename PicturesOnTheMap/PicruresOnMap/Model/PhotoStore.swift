//
//  PhotoStore.swift
//  PicruresOnMap
//
//  Created by Abrar on 15/04/1442 AH.
//

import Foundation

//Initiating the web service requests
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
    
}
