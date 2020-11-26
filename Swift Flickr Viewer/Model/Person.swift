//
//  Person.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 23/11/2020.
//

import Foundation

// flickr.people.getInfo

struct PersonRequest {
    let personURL    : URL

    init(personID: String) {
        let urlString = "https://www.flickr.com/services/rest/?method=flickr.people.getInfo&api_key=\(API.key)&user_id=\(personID)&format=json&nojsoncallback=1"
        guard let resourceURL = URL(string: urlString) else { fatalError() }
        self.personURL = resourceURL
    }

    func fetchPerson(completion: @escaping (Result<PersonResponse, Error>) -> ()) {
        URLSession.shared.dataTask(with: personURL) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            do {
                let person = try JSONDecoder().decode(PersonResponse.self, from: data!)
                completion(.success(person))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}

struct PersonResponse: Codable {
    let person  : Person
    let stat    : String
    
    struct Person: Codable {
        let id          : String
        let nsid        : String
        let ispro       : Int
        let can_buy_pro : Int
        let iconserver  : String
        let iconfarm    : Int
        let path_alias  : String
        let has_stats   : String
        let pro_badge   : String?
        let expire      : String?
        let username    : UserName
        let realname    : RealName
        let location    : Location
        let timezone    : TimeZone
        let description : Description
        let photosurl   : PhotosURL
        let profileurl  : ProfileURL
        let mobileurl   : MobileURL
        let photos      : PersonPhotos
        
        
        struct UserName : Codable {
            let _content : String
        }
        struct RealName: Codable {
                let _content : String
            }
        struct Location: Codable {
                let _content : String
            }
        struct TimeZone: Codable {
            let label         : String
            let offset        : String
            let timezone_id   : String
        }
        struct Description: Codable {
            let _content : String
        }
        struct PhotosURL: Codable {
            let _content : String
        }
        struct ProfileURL: Codable {
            let _content : String
        }
        struct MobileURL: Codable {
            let _content : String
        }
        struct PersonPhotos: Codable {
            let firstdatetaken: FirstDateTaken
            struct FirstDateTaken: Codable {
                let _content: String
            }
            let firstdate: FirstDate
            struct FirstDate: Codable {
                let _content: String
            }
            let count: Count
            struct Count: Codable {
                let _content: Int
            }
        }
    }
}
