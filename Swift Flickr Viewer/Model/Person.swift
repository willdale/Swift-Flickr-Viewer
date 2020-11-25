//
//  Person.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 23/11/2020.
//

import Foundation

struct PersonResponse: Codable {
    let person      : Person
    struct Person: Codable {
        let id          : String
        let nsid        : String
        let ispro       : Int
        let can_buy_pro : Int
        let iconserver  : String
        let iconfarm    : Int
        let path_alias  : String
        let has_stats   : String
        let pro_badge   : String
        let expire      : String
        let username    : UserName
        struct UserName : Codable {
            let _content : String
        }
        let realname: RealName
        struct RealName: Codable {
            let _content : String
        }
        let location: Location
        struct Location: Codable {
            let _content : String
        }
        let timezone: TimeZone
        struct TimeZone: Codable {
            let label         : String
            let offset        : String
            let timezone_id   : String
        }
        let description: Description
        struct Description: Codable {
            let _content : String
        }
        let photosurl: PhotosURL
        struct PhotosURL: Codable {
            let _content : String
        }
        let profileurl: ProfileURL
        struct ProfileURL: Codable {
            let _content : String
        }
        let mobileurl: MobileURL
        struct MobileURL: Codable {
            let _content : String
        }
        let photos: PersonPhotos
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
    let stat : String
}








