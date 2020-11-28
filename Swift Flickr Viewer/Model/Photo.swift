//
//  Photo.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 21/11/2020.
//

import Foundation

//flickr.photos.search

enum CollectionType: String {
    case tag
    case group
    case person
}

struct PhotoRequest {
    let photoURL    : URL

    init(photoQuery: String, type: CollectionType, photosPerPage: Int) {
        
        let base = "https://www.flickr.com/services/rest/"
        let method = "?method=flickr.photos.search"
        let key = "&api_key=\(API.key)"
        var search = ""
        
        switch type {
        case .tag:
            search = "&tags=\(photoQuery)"
        case .group:
            search = "&group_id=\(photoQuery)"
        case .person:
            search = "&user_id=\(photoQuery)"
        }
        
        let perPage = "&per_page=\(photosPerPage)"
        let format = "&format=json&nojsoncallback=1"
        let urlString = base+method+key+search+perPage+format
        

        guard let resourceURL = URL(string: urlString) else { fatalError() }
        self.photoURL = resourceURL
    }

    func fetchPhotos(completion: @escaping (Result<PhotoResponse, Error>) -> ()) {
        URLSession.shared.dataTask(with: photoURL) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            do {
                let photos = try JSONDecoder().decode(PhotoResponse.self, from: data!)
                completion(.success(photos))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}

struct PhotoResponse: Codable, Hashable {
    let photos  : Photos
    let stat    : String
    
    struct Photos: Codable, Hashable {
        let page    : Int
        let pages   : Int
        let perpage : Int
        let total   : String
        let photo   : [Photo]
        
        struct Photo: Codable, Hashable {
            let id          : String
            let owner       : String
            let secret      : String
            let server      : String
            let farm        : Int
            let title       : String
            let ispublic    : Int
            let isfriend    : Int
            let isfamily    : Int
        }
    }
}




