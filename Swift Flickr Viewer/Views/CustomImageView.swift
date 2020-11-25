//
//  CustomImageView.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 23/11/2020.
//

import UIKit

class CustomImageView: UIImageView {
    func loadImage(using urlString: String) {
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
//                print("Error Loading Photo: \(error!.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }).resume()
    }
}

class CustomProfileImageView: UIImageView {
    func loadImage(using urlString: String) {
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }).resume()
    }
    func loadFallBackImage() {
        let url = URL(string: "https://www.flickr.com/images/buddyicon.gif")
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
//                print("Error Loading FallBack: \(error!.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }).resume()
    }
}
