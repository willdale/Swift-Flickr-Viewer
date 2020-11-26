//
//  Group.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 26/11/2020.
//

import Foundation

// flickr.groups.getInfo
struct GroupRequest {
    let groupURL    : URL
    
    init(groupID: String) {
        let urlString = "https://www.flickr.com/services/rest/?method=flickr.groups.getInfo&api_key=\(API.key)&group_id=\(groupID)&format=json&nojsoncallback=1"
        guard let resourceURL = URL(string: urlString) else { fatalError() }
        self.groupURL = resourceURL
    }
    
    func fetchGroup(completion: @escaping (Result<GroupResponse, Error>) -> ()) {
        URLSession.shared.dataTask(with: groupURL) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            do {
                let group = try JSONDecoder().decode(GroupResponse.self, from: data!)
                completion(.success(group))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}

struct GroupResponse: Codable {
    let group : Group
    let stat: String
    
    struct Group: Codable {
        let id          : String
        let nsid        : String
        let path_alias  : String
        let iconserver  : String
        let iconfarm    : Int
        let name: Name
        let description: Description
        let rules: Rules
        let members: Members
        let pool_count: PoolCount
        let topic_count: TopicCount
        let privacy: Privacy
        let lang: String?
        let ispoolmoderated: Int
        let roles: Roles
        let photo_limit_opt_out: String
        let datecreate: DateCreate
        let dateactivity: DateActivity
        let eighteenplus: Int
        let invitation_only: Int
        let blast: Blast
        let throttle: Throttle
        let restrictions: Restrictions
        
        struct Name: Codable {
            let _content: String
        }
        struct Description: Codable {
            let _content: String
        }
        struct Rules: Codable {
            let _content: String
        }
        struct Members: Codable {
            let _content: String
        }
        struct PoolCount: Codable {
            let _content: String
        }
        struct TopicCount: Codable {
            let _content: String
        }
        struct Privacy: Codable {
            let _content: String
        }
        struct Roles: Codable {
            let member: String
            let moderator: String
            let admin: String
        }
        struct DateCreate: Codable {
            let _content: String
        }
        struct DateActivity: Codable {
            let _content: String
        }
        struct Blast: Codable {
            let _content: String
            let date_blast_added: String
            let user_id: String
        }
        struct Throttle: Codable {
            let count: String
            let mode: String
        }
        struct Restrictions: Codable {
            let photos_ok       : Int
            let videos_ok       : Int
            let images_ok       : Int
            let screens_ok      : Int
            let art_ok          : Int
            let safe_ok         : Int
            let moderate_ok     : Int
            let restricted_ok   : Int
            let has_geo         : Int
        }
    }
}
