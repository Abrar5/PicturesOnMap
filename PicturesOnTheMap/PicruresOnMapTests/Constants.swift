//
//  Constants.swift
//  PicruresOnMapTests
//
//  Created by user on 18/04/1442 AH.
//

import Foundation

enum Constants {
    static let urlString = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=b2f9f1783412cdf8fe6aef63e11ca7fd&safe_search=1&has_geo=1&lat=24.853962867051948&lon=46.7134110745225&radius=0.5&extras=url_n%2C+geo%2C+date_taken&per_page=30&format=json&nojsoncallback=1"
    
    static let url = URL(string: urlString)!
    static let date = Date()
    
    static let latitude = 24.85396286705194
    static let longitude = 46.7134110745225
}

