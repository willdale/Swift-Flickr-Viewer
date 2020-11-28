//
//  CustomImageView.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 23/11/2020.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    func loadImage(using urlString: String) {
    
        let url = URL(string: urlString)
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                return
            }
            
            if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                DispatchQueue.main.async {
                    self.image = imageToCache
                }
                DispatchQueue.global().async {
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                
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
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }).resume()
    }
}
